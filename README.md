# Advanced-Hands-on-fMRI-Analysis-Class

In this project, I investigated whether the pattern of brain activity for lookalike objects generalizes to their corresponding animate objects or object identity in three regions of interest (ROIs): primary visual cortex (V1), anterior ventral temporal cortex (VTC-ant), and posterior ventral temporal cortex (VTC-post). Using One-vs-One multiclass decoding, I trained classifiers on fMRI data evoked by lookalike objects and tested them on fMRI data caused by animate and inanimate objects. The results showed that the pattern of BOLD activity for lookalike objects generalized to matching animate objects in VTC-ant and VTC-post but not in V1. Additionally, the pattern of activity for lookalike objects was highly significant in classifying inanimate objects in all three ROIs.

Furthermore, I used representational similarity analysis (RSA) to test the object space organization in the three ROIs based on object appearance or object animacy. The results indicated that both visual appearance and animacy properties drove object space organization in VTC-ant, while only information related to visual appearance was encoded in VTC-post.

## Dataset of images shown during fMRI

<img width="1126" alt="226024705-cd1937ae-74cd-4970-93e3-a0e81eff278f" src="https://user-images.githubusercontent.com/44211738/229634243-54644aa8-ab27-4a4e-b028-410843da35e8.png">

## Results

- Representational dissimilarity matrices:
![ROIs_across_subjects](https://user-images.githubusercontent.com/44211738/159066116-370de2c4-126c-4216-81bb-9dec307662a4.png)

- Representational similarity analysis: 
![RSA Between Models and ROIs](https://user-images.githubusercontent.com/44211738/159066126-8acdc190-24d7-4d0f-a560-29642b8ce1a9.png)

## Acknowledgement
- Thank you Dr. Stefania Bracci, Dr. Moritz Wurm, and Dr. Scott L. Fairhall for this great course!
