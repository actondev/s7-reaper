# (ns `aod.c.os`)

## `path-filename` <small>procedure?</small>
(path-filename path) Returns the filename component of the given path
## `execute` <small>procedure?</small>
(execute command) Returns the external command on the system
## `temp-directory-path` <small>procedure?</small>
(temp-directory-path) Returns the directory location suitable for temporary files
# (ns `rpr.actions.sws-track`)

## `toggle-zoom-to-selected-items,-hide-other-tracks` <small>procedure?</small>

## `toggle-zoom-to-selected-items,-minimize-other-tracks` <small>procedure?</small>

## `toggle-zoom-to-selected-items-or-time-selection,-hide-other-tracks` <small>procedure?</small>

## `toggle-zoom-to-selected-items-or-time-selection,-minimize-other-tracks` <small>procedure?</small>

## `toggle-zoom-to-selected-tracks-and-time-selection,-hide-others` <small>procedure?</small>

## `toggle-zoom-to-selected-tracks-and-time-selection,-minimize-others` <small>procedure?</small>

## `toggle-zoom-to-selected-tracks-and-time-selection` <small>procedure?</small>

## `vertical-zoom-to-selected-tracks,-minimize-others` <small>procedure?</small>

## `vertical-zoom-to-selected-tracks` <small>procedure?</small>

## `toggle-master-track-select` <small>procedure?</small>

## `unselect-master-track` <small>procedure?</small>

## `select-master-track` <small>procedure?</small>

## `unselect-rec-armed-track<s>` <small>procedure?</small>

## `select-only-rec-armed-track<s>` <small>procedure?</small>

## `select-tracks-with-active-routing-to-selected-track<s>` <small>procedure?</small>

## `select-armed-tracks` <small>procedure?</small>

## `select-tracks-with-flipped-phase` <small>procedure?</small>

## `select-soloed-tracks` <small>procedure?</small>

## `select-unmuted-tracks` <small>procedure?</small>

## `select-muted-tracks` <small>procedure?</small>

## `select-all-folder-start-tracks` <small>procedure?</small>

## `unselect-children-of-selected-folder-track<s>` <small>procedure?</small>

## `unselect-parent<s>-of-selected-folder-track<s>` <small>procedure?</small>

## `select-parent<s>-of-selected-folder-track<s>` <small>procedure?</small>

## `select-only-parent<s>-of-selected-folder-track<s>` <small>procedure?</small>

## `select-children-of-selected-folder-track<s>` <small>procedure?</small>

## `set-last-touched-track-to-match-track-selection-<deprecated>` <small>procedure?</small>

## `select-only-track<s>-with-selected-item<s>` <small>procedure?</small>

## `toggle-<invert>-track-selection` <small>procedure?</small>

## `toggle-between-current-and-saved-track-selection` <small>procedure?</small>

## `restore-saved-track-selection` <small>procedure?</small>

## `save-current-track-selection` <small>procedure?</small>

## `set-all-selected-tracks-inputs-to-match-first-selected-track` <small>procedure?</small>

## `set-track-name-from-first-selected-item-in-project` <small>procedure?</small>

## `set-track-name-from-first-selected-item-on-track` <small>procedure?</small>

## `delete-track<s>-with-children-<prompt>` <small>procedure?</small>

## `create-and-select-first-track` <small>procedure?</small>

## `insert-track-above-selected-tracks` <small>procedure?</small>

## `unset-selected-track<s>-monitor-track-media-while-recording` <small>procedure?</small>

## `set-selected-track<s>-monitor-track-media-while-recording` <small>procedure?</small>

## `set-selected-track<s>-record-output-mode-based-on-items` <small>procedure?</small>

## `minimize-selected-track<s>` <small>procedure?</small>

## `unbypass-fx-on-selected-track<s>` <small>procedure?</small>

## `bypass-fx-on-selected-track<s>` <small>procedure?</small>

## `unmute-all-sends-from-selected-track<s>` <small>procedure?</small>

## `mute-all-sends-from-selected-track<s>` <small>procedure?</small>

## `toggle-mute-on-receives-for-selected-track<s>` <small>procedure?</small>

## `unmute-all-receives-for-selected-track<s>` <small>procedure?</small>

## `mute-all-receives-for-selected-track<s>` <small>procedure?</small>

## `set-all-master-track-outputs-muted` <small>procedure?</small>

## `set-all-master-track-outputs-unmuted` <small>procedure?</small>

## `toggle-master-parent-send-on-selected-track<s>` <small>procedure?</small>

## `disable-master-parent-send-on-selected-track<s>` <small>procedure?</small>

## `enable-master-parent-send-on-selected-track<s>` <small>procedure?</small>

## `hide-master-track-in-track-control-panel` <small>procedure?</small>

## `show-master-track-in-track-control-panel` <small>procedure?</small>

## `select-locked-items-on-selected-track<s>` <small>procedure?</small>

## `select-previous-item,-keeping-current-selection-<across-tracks>` <small>procedure?</small>

## `select-next-item,-keeping-current-selection-<across-tracks>` <small>procedure?</small>

## `select-previous-item-<across-tracks>` <small>procedure?</small>

## `select-next-item-<across-tracks>` <small>procedure?</small>

## `select-unmuted-items-on-selected-track<s>` <small>procedure?</small>

## `select-muted-items-on-selected-track<s>` <small>procedure?</small>

## `toggle-selection-of-items-on-selected-track<s>` <small>procedure?</small>

## `unselect-upper-leftmost-item-on-selected-track<s>` <small>procedure?</small>

## `select-upper-leftmost-item-on-selected-track<s>` <small>procedure?</small>

## `select-lower-leftmost-item-on-selected-track<s>` <small>procedure?</small>

## `unselect-all-items-on-selected-track<s>` <small>procedure?</small>

## `insert-file-matching-selected-track<s>-name` <small>procedure?</small>

## `delete-all-items-on-selected-track<s>` <small>procedure?</small>

## `toggle-mute-of-items-on-selected-track<s>` <small>procedure?</small>

## `unindent-selected-track<s>` <small>procedure?</small>

## `indent-selected-track<s>` <small>procedure?</small>

## `make-folder-from-selected-tracks` <small>procedure?</small>

## `set-selected-track<s>-to-same-folder-as-previous-track` <small>procedure?</small>

## `unselect-all-items-tracks-env-points` <small>procedure?</small>

## `unselect-all-items-tracks-env-points-<depending-on-focus>` <small>procedure?</small>

## `remove-items-tracks-env,-<obey-time-selection>` <small>procedure?</small>

## `cut-items-tracks-env-<obey-time-selection>` <small>procedure?</small>

## `copy-items-tracks-env-<obey-time-selection>` <small>procedure?</small>

## `set-selected-tracks-pan-law-to-default` <small>procedure?</small>

## `snapshot-current-track-visibility` <small>procedure?</small>

## `clear-tracklist-filter` <small>procedure?</small>

## `hide-unselected-track<s>` <small>procedure?</small>

## `show-selected-track<s>,-hide-others` <small>procedure?</small>

## `show-selected-track<s>-in-tcp,-hide-others` <small>procedure?</small>

## `show-selected-track<s>-in-mcp,-hide-others` <small>procedure?</small>

## `hide-all-tracks` <small>procedure?</small>

## `show-all-tracks-in-tcp` <small>procedure?</small>

## `show-all-tracks-in-mcp` <small>procedure?</small>

## `show-all-tracks` <small>procedure?</small>

## `toggle-selected-track<s>-fully-visible-hidden` <small>procedure?</small>

## `toggle-selected-track<s>-visible-in-tcp` <small>procedure?</small>

## `toggle-selected-track<s>-visible-in-mcp` <small>procedure?</small>

## `hide-selected-track<s>-from-tcp` <small>procedure?</small>

## `hide-selected-track<s>-from-mcp` <small>procedure?</small>

## `show-selected-track<s>-in-tcp` <small>procedure?</small>

## `show-selected-track<s>-in-mcp` <small>procedure?</small>

## `hide-selected-track<s>` <small>procedure?</small>

## `show-selected-track<s>-in-tcp-and-mcp` <small>procedure?</small>

## `show-selected-track<s>-in-tcp-only` <small>procedure?</small>

## `show-selected-track<s>-in-mcp-only` <small>procedure?</small>

## `toggle-snapshot-show-only-for-selected-tracks` <small>procedure?</small>

## `copy-new-snapshot-<all-track<s>>` <small>procedure?</small>

## `copy-new-snapshot-<selected-track<s>>` <small>procedure?</small>

## `new-snapshot-<selected-track<s>>` <small>procedure?</small>

## `new-snapshot-<all-tracks>` <small>procedure?</small>

## `select-current-snapshot-track<s>` <small>procedure?</small>

## `delete-selected-track<s>-from-all-snapshots` <small>procedure?</small>

## `delete-selected-track<s>-from-current-snapshot` <small>procedure?</small>

## `add-selected-track<s>-to-all-snapshots` <small>procedure?</small>

## `add-selected-track<s>-to-current-snapshot` <small>procedure?</small>

## `select-item<s>-with-saved-state-on-selected-track<s>` <small>procedure?</small>

## `restore-selected-track<s>-mutes-<+receives,-children>` <small>procedure?</small>

## `save-selected-track<s>-mutes-<+receives,-children>` <small>procedure?</small>

## `restore-last-item-selection-on-selected-track<s>` <small>procedure?</small>

## `restore-active-takes-on-selected-track<s>` <small>procedure?</small>

## `save-active-takes-on-selected-track<s>` <small>procedure?</small>

## `set-selected-track<s>-item<s>-to-custom-color...` <small>procedure?</small>

## `set-selected-track<s>-item<s>-to-one-random-color` <small>procedure?</small>

## `set-selected-item<s>-to-respective-track-color` <small>procedure?</small>

## `set-selected-item<s>-to-ordered-custom-colors-per-track` <small>procedure?</small>

## `set-selected-item<s>-to-color-gradient-per-track` <small>procedure?</small>

## `set-selected-track<s>-children-to-same-color` <small>procedure?</small>

## `set-selected-track<s>-to-ordered-custom-colors` <small>procedure?</small>

## `set-selected-tracks-to-color-gradient` <small>procedure?</small>

## `set-selected-track<s>-to-random-custom-color<s>` <small>procedure?</small>

## `set-selected-track<s>-to-one-random-custom-color` <small>procedure?</small>

## `set-selected-track<s>-to-next-custom-color` <small>procedure?</small>

## `set-selected-track<s>-to-color-black` <small>procedure?</small>

## `set-selected-track<s>-to-color-white` <small>procedure?</small>

## `toggle-auto-track-coloring-enable` <small>procedure?</small>

## `cmd` <small>procedure?</small>

# (ns `rpr.actions.item`)

## `set-cursor-to-next-take-marker-in-selected-items` <small>procedure?</small>

## `set-cursor-to-previous-take-marker-in-selected-items` <small>procedure?</small>

## `quick-add-take-marker-at-mouse-position` <small>procedure?</small>

## `quick-add-take-marker-at-play-position-or-edit-cursor` <small>procedure?</small>

## `delete-take-marker-at-mouse-position` <small>procedure?</small>

## `add-edit-take-marker-at-mouse-position` <small>procedure?</small>

## `delete-all-take-markers` <small>procedure?</small>

## `delete-take-marker-at-cursor` <small>procedure?</small>

## `add-edit-take-marker-at-play-position-or-edit-cursor` <small>procedure?</small>

## `convert-embedded-source-transient-information-to-transient-guides` <small>procedure?</small>

## `toggle-force-inactive-take-media-offline` <small>procedure?</small>

## `toggle-force-media-offline` <small>procedure?</small>

## `force-no-pre-echo-reduction-mode-for-stretch-markers` <small>procedure?</small>

## `force-balanced-mode-for-stretch-markers` <small>procedure?</small>

## `force-transient-optimized-mode-for-stretch-markers` <small>procedure?</small>

## `set-item-start-to-source-media-start` <small>procedure?</small>

## `set-item-start-end-to-source-media-start-end` <small>procedure?</small>

## `glue-items-<auto-increase-channel-count-with-take-fx>` <small>procedure?</small>

## `glue-items,-ignoring-time-selection-<auto-increase-channel-count-with-take-fx>` <small>procedure?</small>

## `render-items-to-new-take` <small>procedure?</small>

## `move-items-to-subproject-<non-destructive-glue>` <small>procedure?</small>

## `apply-track-take-fx-to-items-<multichannel-output>` <small>procedure?</small>

## `reset-stretch-marker-at-current-position` <small>procedure?</small>

## `edit-stretch-marker-at-cursor` <small>procedure?</small>

## `propagate-to-all-similarly-named-items` <small>procedure?</small>

## `propagate-to-similarly-named-items-on-track` <small>procedure?</small>

## `close-item-inline-editors` <small>procedure?</small>

## `go-to-nearest-stretch-marker` <small>procedure?</small>

## `go-to-previous-stretch-marker` <small>procedure?</small>

## `go-to-next-stretch-marker` <small>procedure?</small>

## `remove-stretch-marker-at-current-position` <small>procedure?</small>

## `set-item-name-from-active-take-filename` <small>procedure?</small>

## `force-tonal-optimized-mode-for-stretch-markers` <small>procedure?</small>

## `add-stretch-marker-at-mouse-position` <small>procedure?</small>

## `snap-stretch-markers-in-time-selection-to-grid` <small>procedure?</small>

## `snap-stretch-markers-to-grid` <small>procedure?</small>

## `remove-all-stretch-markers-in-time-selection` <small>procedure?</small>

## `remove-all-stretch-markers` <small>procedure?</small>

## `add-stretch-markers-at-time-selection` <small>procedure?</small>

## `add-stretch-marker-at-cursor` <small>procedure?</small>

## `split-items-at-start-of-fade-out-<unless-crossfaded>` <small>procedure?</small>

## `split-items-at-end-of-fade-in-<unless-crossfaded>` <small>procedure?</small>

## `open-associated-project-in-new-tab` <small>procedure?</small>

## `insert-time-on-tracks-and-paste-items` <small>procedure?</small>

## `collapse-empty-take-lanes` <small>procedure?</small>

## `set-item-ends-to-start-of-next-item` <small>procedure?</small>

## `reorder-adjacent-items-randomly` <small>procedure?</small>

## `remove-active-take-from-midi-source-data-pool-<aka-un-pool,-un-ghost,-make-unique>` <small>procedure?</small>

## `select-all-other-media-items-that-share-pooled-<ghost>-midi-source-data-with-selected-items` <small>procedure?</small>

## `glue-items` <small>procedure?</small>

## `cycle-through-crossfade-shapes` <small>procedure?</small>

## `cycle-through-fade-out-shapes` <small>procedure?</small>

## `cycle-through-fade-in-shapes` <small>procedure?</small>

## `explode-rex-item-into-beat-slices` <small>procedure?</small>

## `fit-items-to-time-selection,-looping-if-needed` <small>procedure?</small>

## `fit-items-to-time-selection,-padding-with-silence-if-needed` <small>procedure?</small>

## `choose-active-take-for-item-under-mouse` <small>procedure?</small>

## `move-active-takes-to-top-lane` <small>procedure?</small>

## `rotate-take-lanes-backward` <small>procedure?</small>

## `rotate-take-lanes-forward` <small>procedure?</small>

## `add-an-empty-take-lane-after-the-active-take` <small>procedure?</small>

## `add-an-empty-take-lane-before-the-active-take` <small>procedure?</small>

## `remove-the-empty-take-lane-after-the-active-take` <small>procedure?</small>

## `remove-the-empty-take-lane-before-the-active-take` <small>procedure?</small>

## `remove-all-empty-take-lanes` <small>procedure?</small>

## `move-items-to-time-selection,-trim-loop-to-fit` <small>procedure?</small>

## `copy-items-to-time-selection,-trim-loop-to-fit` <small>procedure?</small>

## `duplicate-selected-area-of-items` <small>procedure?</small>

## `duplicate-items` <small>procedure?</small>

## `move-and-stretch-items-to-fit-time-selection` <small>procedure?</small>

## `disable-default-fadein-fadeout` <small>procedure?</small>

## `enable-default-fadein-fadeout` <small>procedure?</small>

## `toggle-enable-disable-default-fadein-fadeout` <small>procedure?</small>

## `remove-fade-in-and-fade-out` <small>procedure?</small>

## `remove-fade-out` <small>procedure?</small>

## `remove-fade-in` <small>procedure?</small>

## `snap-items-to-nearest-snap-point` <small>procedure?</small>

## `snap-items-right` <small>procedure?</small>

## `snap-items-left` <small>procedure?</small>

## `select-previous-adjacent-non-overlapping-item` <small>procedure?</small>

## `select-next-adjacent-non-overlapping-item` <small>procedure?</small>

## `invert-selection` <small>procedure?</small>

## `paste-items-tracks,-creating-pooled-<ghost>-midi-items-and-automation-items-regardless-of-preferences-media-midi-and-preferences-media-automation-settings` <small>procedure?</small>

## `move,-stretch,-and-loop-items-to-fit-time-selection` <small>procedure?</small>

## `crossfade-any-overlapping-items` <small>procedure?</small>

## `split-items-at-timeline-grid` <small>procedure?</small>

## `split-items-at-project-markers` <small>procedure?</small>

## `remove-content-<trim>-behind-items` <small>procedure?</small>

## `set-item-mix-behavior-to-project-default` <small>procedure?</small>

## `set-item-mix-behavior-to-always-replace` <small>procedure?</small>

## `explode-midi-note-rows-<pitch>-to-new-items` <small>procedure?</small>

## `set-item-mix-behavior-to-always-mix` <small>procedure?</small>

## `set-item-mix-behavior-to-enclosed-items-replace-enclosing-items` <small>procedure?</small>

## `crossfade-items-within-time-selection` <small>procedure?</small>

## `set-focus-to-item-under-mouse-cursor` <small>procedure?</small>

## `explode-multichannel-audio-or-midi-to-new-one-channel-items` <small>procedure?</small>

## `solo-active-take-of-multitake-item-within-time-selection` <small>procedure?</small>

## `mute-active-take-of-multitake-item-within-time-selection` <small>procedure?</small>

## `show-notes-for-items...` <small>procedure?</small>

## `open-item-inline-editors` <small>procedure?</small>

## `split-at-previous-zero-crossing` <small>procedure?</small>

## `create-chromatic-midi-from-items` <small>procedure?</small>

## `dynamic-split-items...` <small>procedure?</small>

## `split-items-at-edit-cursor-<select-right>` <small>procedure?</small>

## `split-items-at-edit-cursor-<select-left>` <small>procedure?</small>

## `split-items-at-edit-cursor-<no-change-selection>` <small>procedure?</small>

## `split-item-under-mouse-cursor-<select-right>` <small>procedure?</small>

## `split-item-under-mouse-cursor-<select-left>` <small>procedure?</small>

## `split-item-under-mouse-cursor` <small>procedure?</small>

## `shrink-to-first-and-last-media-cues` <small>procedure?</small>

## `shrink-to-last-media-cue` <small>procedure?</small>

## `shrink-to-first-media-cue` <small>procedure?</small>

## `split-at-media-cues` <small>procedure?</small>

## `select-all-items-on-selected-tracks-in-current-time-selection` <small>procedure?</small>

## `select-all-items-in-current-time-selection` <small>procedure?</small>

## `set-to-default-color` <small>procedure?</small>

## `set-to-one-random-color` <small>procedure?</small>

## `set-to-random-colors` <small>procedure?</small>

## `set-to-custom-color...` <small>procedure?</small>

## `import-item-media-cues-as-project-markers` <small>procedure?</small>

## `auto-reposition-items-in-free-item-positioning-mode` <small>procedure?</small>

## `implode-items-across-tracks-into-items-on-one-track` <small>procedure?</small>

## `remove-fx-for-item-take` <small>procedure?</small>

## `show-fx-chain-for-item-take` <small>procedure?</small>

## `set-item-end-to-source-media-end` <small>procedure?</small>

## `set-item-end-to-cursor` <small>procedure?</small>

## `glue-items,-including-leading-fade-in-and-trailing-fade-out` <small>procedure?</small>

## `render-items-to-new-take-<preserve-source-type>` <small>procedure?</small>

## `heal-splits-in-items` <small>procedure?</small>

## `set-snap-offset-to-nearest-grid-line` <small>procedure?</small>

## `set-snap-offset-to-cursor` <small>procedure?</small>

## `toggle-selection-of-item-under-mouse-cursor` <small>procedure?</small>

## `select-item-under-mouse-cursor-<leaving-other-items-selected>` <small>procedure?</small>

## `select-item-under-mouse-cursor` <small>procedure?</small>

## `trim-items-right-of-cursor` <small>procedure?</small>

## `trim-items-left-of-cursor` <small>procedure?</small>

## `fade-items-out-from-cursor` <small>procedure?</small>

## `fade-items-in-to-cursor` <small>procedure?</small>

## `trim-items-to-selected-area` <small>procedure?</small>

## `set-selected-media-temporarily-offline` <small>procedure?</small>

## `set-selected-media-online` <small>procedure?</small>

## `apply-track-take-fx-to-items-<midi-output>` <small>procedure?</small>

## `select-all-items-in-track` <small>procedure?</small>

## `glue-items,-ignoring-time-selection` <small>procedure?</small>

## `apply-track-take-fx-to-items-<mono-output>` <small>procedure?</small>

## `quantize-item-positions-to-grid...` <small>procedure?</small>

## `auto-trim-split-items-<remove-silence>...` <small>procedure?</small>

## `remove-selected-area-of-items` <small>procedure?</small>

## `cut-selected-area-of-items` <small>procedure?</small>

## `move-to-source-preferred-position-<used-by-bwf>` <small>procedure?</small>

## `unselect-all-items` <small>procedure?</small>

## `reverse-items-to-new-take` <small>procedure?</small>

## `glue-items,-ignoring-time-selection,-including-leading-fade-in-and-trailing-fade-out` <small>procedure?</small>

## `apply-track-take-fx-to-items` <small>procedure?</small>

## `open-item-copies-in-secondary-external-editor` <small>procedure?</small>

## `open-items-in-secondary-external-editor` <small>procedure?</small>

## `split-items-at-play-cursor` <small>procedure?</small>

## `split-items-at-edit-or-play-cursor-<ignoring-grouping>` <small>procedure?</small>

## `select-all-items` <small>procedure?</small>

## `open-in-built-in-midi-editor-<set-default-behavior-in-preferences>` <small>procedure?</small>

## `open-item-copies-in-primary-external-editor` <small>procedure?</small>

## `open-items-in-primary-external-editor` <small>procedure?</small>

## `set-all-media-online` <small>procedure?</small>

## `set-all-media-offline` <small>procedure?</small>

## `split-items-at-time-selection` <small>procedure?</small>

## `copy-selected-area-of-items` <small>procedure?</small>

## `paste-items-tracks` <small>procedure?</small>

## `copy-loop-of-selected-area-of-audio-items` <small>procedure?</small>

## `split-items-at-edit-or-play-cursor` <small>procedure?</small>

## `remove-items` <small>procedure?</small>

## `cmd` <small>procedure?</small>

# (ns `rpr.helpers.item`)

## `active-take-name` <small>procedure?</small>

## `start-end` <small>procedure?</small>

## `track-items` <small>procedure?</small>

## `selected` <small>procedure?</small>

## `set-only-selected` <small>procedure?</small>

# (ns `rpr.common`)

## `cmd` <small>procedure?</small>

# (ns `freesound.core`)

## `search&random-preview` <small>procedure?</small>

## `get-preview` <small>procedure?</small>

## `get` <small>procedure?</small>

## `search&random` <small>procedure?</small>

## `search` <small>procedure?</small>

## `make-filter` <small>procedure?</small>

## `*default-preview*` <small>string?</small>

## `*token*` <small>string?</small>

# (ns `secrets`)

## `freesound` <small>string?</small>

# (ns `aod.c.curl`)
Basic bindings for libcurl
## `easy-escape` <small>procedure?</small>
(easy-escape string)
## `curl` <small>procedure?</small>
(curl url (out #f) (opts *default-curl-opts*))
## `*default-opts*` <small>let?</small>
value `(inlet :ssl-verify-peer 1 :follow-location 1)`
# (ns `rpr`)

## `GetCursorPosition` <small>procedure?</small>
(GetCursorPosition)
## `SetEditCurPos` <small>procedure?</small>
(SetEditCurPos time &optional move-view?=false seek-play?=false)
## `GetSet_LoopTimeRange` <small>procedure?</small>
(GetSet_LoopTimeRange set? loop? start end allow-auto-seek)
## `NamedCommandLookup` <small>procedure?</small>
(NamedCommandLookup name-id)
## `ReverseNamedCommandLookup` <small>procedure?</small>
(ReverseNamedCommandLookup id) Returns #f or the named id (string)
## `Main_OnCommand` <small>procedure?</small>
(Main_OnCommand cmd-id)
## `RegisterGui` <small>procedure?</small>
(RegisterGui name script-file) CUSTOM (not part of reaper): Registers an action under name which runs a gui script
## `RegisterAction` <small>procedure?</small>
(RegisterAction name fn) Adds a menu item inside reaper
## `CF_EnumerateActions` <small>procedure?</small>
(CF_EnumerateActions section idx) ret (retval:int name:string)
## `UpdateArrange` <small>procedure?</small>
(UpdateArrange)
## `GetSelectedTrack` <small>procedure?</small>
(GetSelectedTrack ReapProject* idx) TODO project* always 0
## `CountSelectedTracks` <small>procedure?</small>
(CountSelectedTracks &optional ReapProject*=0) TODO project is always 0
## `SetTrackSelected` <small>procedure?</small>
(SetTrackSelected *media-track sel:bool)
## `SetOnlyTrackSelected` <small>procedure?</small>
(SetOnlyTrackSelected *media-track)
## `GetMediaItem_Track` <small>procedure?</small>
(GetMediaItem_Track *media-item)
## `CountTracks` <small>procedure?</small>
(CountTracks &optional ReaProject=0) TODO ReaProject always 0
## `type-media-track` <small>integer?</small>

## `GetActiveTake` <small>procedure?</small>
(GetActiveTake media-item*)
## `GetSetMediaItemTakeInfo_String` <small>procedure?</small>
(GetSetMediaItemTakeInfo_String take* param-name)
## `type-media-take` <small>integer?</small>

## `InsertMedia` <small>procedure?</small>
(InsertMedia file-path mode=0) mode:
- 0 add to current track
- 1 add new track
- 3 add to selected items as takes
- &4 stretch/loop to fit time sel
- &8=try to match tempo 1x
- &16=try to match tempo 0.5x
- &32=try to match tempo 2x
- &64=don't preserve pitch when matching tempo
- &128=no loop/section if startpct/endpct set
- &256=force loop regardless of global preference for looping imported items
- &512=use high word as absolute track index if mode&3==0
## `GetMediaItemInfo_Value` <small>procedure?</small>
(GetMediaItemInfo_Value item param-name)
## `SetMediaItemSelected` <small>procedure?</small>
(SetMediaItemSelected *media-item selected?)
## `GetSelectedMediaItem` <small>procedure?</small>
(GetSelectedMediaItem ReaProject* idx) TODO ReaProject is always 0
## `CountSelectedMediaItems` <small>procedure?</small>
(CountSelectedMediaItems) TODO pass ReaProject
## `type-media-item` <small>integer?</small>

## `*reaper_plugin_info_t*` <small>c-pointer?</small>

## `ReaperExtBase*` <small>c-pointer?</small>

# (ns `rpr+.freesound`)

## `insert-random-children` <small>procedure?</small>

## `insert-random-preview` <small>procedure?</small>

## `*download-dir*` <small>string?</small>

# (ns `aod.c.json`)
Basic bindings for nlohmann/json
## `parse` <small>procedure?</small>
(parse json-str) Returns a json c-object
## `type-json` <small>integer?</small>

# (ns `region-items.core`)

## `propagate` <small>procedure?</small>

## `clear` <small>procedure?</small>

## `select` <small>procedure?</small>

# (ns `aod.c.string`)

## `lowercase` <small>procedure?</small>
(lowercase str)
## `uppercase` <small>procedure?</small>
(uppercase str)
## `replace` <small>procedure?</small>
(replace str regex replacement)
## `match-at` <small>procedure?</small>
(match-at)
## `count-matches` <small>procedure?</small>
(count-matches)
## `search` <small>procedure?</small>
(search str regex) Returns #t or #f
# (ns `rpr.actions.gen`)
Generating functions from the action list
The rpr.actions.item/track/time-selection are generated from here
## `gen-sws-item` <small>procedure?</small>

## `gen-sws-track` <small>procedure?</small>

## `gen-item` <small>procedure?</small>

## `gen-track` <small>procedure?</small>

## `gen-time-selection` <small>procedure?</small>

## `gen-file` <small>procedure?</small>

