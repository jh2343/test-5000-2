
home_path=${PWD}

cd website
rm -rf _site
quarto render 

#deploy
rsync -alrv _site jfhgeorg@gtown.reclaimhosting.com:/home/jfhgeorg/public_html/


cd $home_path


printf 'Would you like to sync with the github server: (y/n)?'
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then 

    # PULL CLOUD REPO TO LOCAL
    git pull 
    
    # change buffer settings 
    git config http.postBuffer 524288000

    # SYNC TO LOCAL REPO TO CLOUD 
    read -p 'ENTER MESSAGE: ' message
    echo "commit message = "$message; 
    
    # ADD CHANGES TO QUEUE
    git add ./; 
    
    # MAIN BRANCH
    git commit -m "$message"; 

    # PUSH NON-MAIN BRANCH
    # git push  -u origin branch_name

    # PUSH MAIN BRANCH
    git push

else
    echo NOT SYNCING TO GITHUB!
fi
