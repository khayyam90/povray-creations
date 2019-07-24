// LINK INCLUDE FILE: SAMPLE LINK OBJECTS
// **************************************
// This file includes a variety of link objects which can be used with
// Link.inc:
//
//    Gold_Chain - can be used to create a fine, golden chain
//    Iron_Chain - can be used to create a heavy, iron chain
//    Rope - can be used to create a thick rope
//    Candy_Cane - when used with the link_twist option, this object
//                 can create a candy-cane like link.  Note that for the
//                 best results you should use a small link_size value
//                 (or a large link_count value).
//    Snake - creates a surface somewhat like snake scales
//    Spikes - can be used to create a spiked chrome wire/chain
//    RailWay - can be used to create rail tracks
//    Beads - can create strings of coloured beads
//    Bubbles - when used with the link_size_turb and link_twist_turb
//              option, this object can create a chain of soap bubbles

#declare Rope = sphere {<0, 0, 0>, 1
   pigment {wrinkles color_map {[0 rgb <.6, .4, .2>] [1 rgb <.58, .4, .18>]}}
   normal {radial .75 frequency 11 scallop_wave rotate z * 90 warp {turbulence .2 octaves 2 lambda 4}}
   scale <.9, 1.1, 1.1>}