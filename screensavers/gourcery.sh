#!/usr/bin/env bash

arch_gourcerer() {
    # Generate a single video to visualize the git commit history of all given repositories
    # Requires gource & ffmpeg
    #
    # Usage:
    # $ arch_gourcerer title owner1/repo1 [ownerN/repoN]

    title=$1
    mkdir -p ~/screensavers "/tmp/gourcery/$title"
    for repo in "${@:2}"
    do
        # Check out the latest version of the main branch
        echo "Cloning $repo..."
        IFS='/' eval 'repo_components=( $repo )'
        owner=${repo_components[0]}
        name=${repo_components[1]}
        git clone "git@github.com:$owner/$name.git" "/tmp/gourcery/$title/$name" >/dev/null 2>&1

        # Generate a log of the repository's git history
        echo "Generating $name git history..."
        gource --output-custom-log "/tmp/gourcery/$title/$name.log" "/tmp/gourcery/$title/$name"
        sed -i '' "s/\(.*\)|/\1|\/$name/" "/tmp/gourcery/$title/$name.log"

        # Clean up
        \rm -rf "/tmp/gourcery/$title/$name"
    done

    # Generate collective git history
    #   Include initial creation/deletion of dummy root file to establish the hidden root directory
    #   Include any extra logs from ~/screensavers (to represent untracked archival or discarding)
    echo "Generating collective git history..."
    sort -n < "/tmp/gourcery/$title/*.log"> "/tmp/gourcery/$(title)_base.log"
    IFS='|' eval 'first_commit=( `head -n 1 /tmp/gourcery/"$title"_base.log` )'
    new_timestamp=$((${first_commit[0]}-1))
    echo -e "$new_timestamp|${first_commit[1]}|A|." >> /tmp/gourcery/"$title"_extra.log
    echo -e "$new_timestamp|${first_commit[1]}|D|." >> /tmp/gourcery/"$title"_extra.log
    cat ~/screensavers/"$title"_extra.log >> /tmp/gourcery/"$title"_extra.log 2>/dev/null
    cat /tmp/gourcery/"$title"_base.log /tmp/gourcery/"$title"_extra.log | sort -n > "/tmp/gourcery/$title.log"

    # Generate video of collective git history
    echo "Running gource..."
    gource "/tmp/gourcery/$title.log" -1440x900 -s 0.5 --file-idle-time 0 --key --title "$title" --hide mouse,filenames --hide-root -r 30 -o "/tmp/gourcery/$title.ppm" &&
        ffmpeg -y -r 30 -f image2pipe -vcodec ppm -i "/tmp/gourcery/$title.ppm" -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -bf 0 "$HOME/screensavers/$title.mp4" </dev/null

    # Clean up
    \rm -rf /tmp/gourcery/"$title"*
    [ -z "$(ls -A /tmp/gourcery)" ] && \rm -rf /tmp/gourcery
    echo "Done!"
}

gourcerer() {
    # Generate videos visualizing git commit history (requires gource & ffmpeg)
    #
    # Usage:
    # $> gourcerer /path/to/config
    #
    # Config format
    # /path/to/repo screen-resolution seconds-per-day frame-rate hidden_fields
    # ~/projects/test_repo 1280x720 1 60 bloom

    mkdir -p ~/screensavers /tmp/gourcerer
    while IFS=$' ' read -r repo_path resolution secs_per_day frame_rate hidden; do

        # Check out the latest version of the main branch
        pushd "$repo_path" >/dev/null || exit
        repo_name=$(basename "$(git rev-parse --show-toplevel)")
        git_source=$(git remote get-url origin)
        git clone "$git_source" "/tmp/gourcerer/$repo_name"

        # Generate git history video
        pushd "/tmp/gourcerer/$repo_name" >/dev/null || exit
        gource -"$resolution" -s "$secs_per_day" --file-idle-time 0 --key --title "$repo_name" --hide "mouse,$hidden" -r "$frame_rate" -o "$repo_name.ppm" &&
            ffmpeg -y -r "$frame_rate" -f image2pipe -vcodec ppm -i "$repo_name.ppm" -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -bf 0 "$HOME/screensavers/$repo_name.mp4" </dev/null

        # Clean up
        \rm -f "$repo_name.ppm"
        popd >/dev/null || exit
        \rm -rf "/tmp/gourcerer/$repo_name"
        popd >/dev/null || exit
    done < "$1"
    \rm -rf /tmp/gourcerer
}

stitch() {
    # Combine all mp4 files into a single video (requires ffmpeg)
    #
    # Usage:
    # $> stitch
    #
    # TODO: parameters?

    pushd ~/screensavers >/dev/null || exit
    IFS=$'\n' videos=($(ls -S *.mp4))
    for((i=0; i < ${#videos[@]}; i+=4))
    do
        IFS= batch=( "${videos[@]:i:4}" )
        while ((${#batch[@]} < 4))
        do
            [ ! -f black.png ] && ffmpeg -f lavfi -i color=c=black:s=2880x1800 -vframes 1 black.png &>/dev/null
            batch+=('black.png')
        done
        ffmpeg -i "${batch[0]}" -i "${batch[1]}" -i "${batch[2]}" -i "${batch[3]}" -lavfi "[0:v][1:v]hstack[top];[2:v][3:v]hstack[bottom];[top][bottom]vstack" screensaver_$((i/4)).mp4
    done
    \rm black.png 2>/dev/null
    popd >/dev/null || exit
}

