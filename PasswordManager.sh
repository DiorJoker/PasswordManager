


echo "パスワードマネージャーへようこそ！"

operation=First



while [ "$operation" != "Exit" ]
do

        echo  "次の選択肢から入力してください(Add Password/Get Password/Exit):"
        read operation

        if [ "$operation" = "Add Password"  ]; then
                echo "サービス名を入力してください:"
                read service
                echo "ユーザー名を入力してください:"
                read user
                echo "パスワードを入力してください:"
                read password

		touch testV2.txt

		encrypted_file="testV.gpg"

		decrypted_file="testV2.txt"
		
		gpg -d "$encrypted_file" > "$decrypted_file"

                echo "$service=$user" >> "$decrypted_file"
                echo "$user=$password" >> "$decrypted_file"
                echo "パスワードの追加は成功しました"
		gpg --passphrase "gomen99" -e -r delta9kit@gmail.com -o testV.gpg testV2.txt
                rm testV2.txt

        elif [ "$operation" = "Get Password" ]; then

		touch testV2.txt

		encrypted_file="testV.gpg"

		decrypted_file="testV2.txt"
		
		gpg -d "$encrypted_file" > "$decrypted_file"

                read -p "サービス名を入力してください" name
                result=$(grep "${name}=" testV2.txt)

                if [ -z "$result" ]; then
                        echo "そのサービスは登録されていません。"
                else
                        user=$(echo "$result" | cut -d'=' -f2)
                        password=$(grep "$user=" testV2.txt | cut -d'=' -f2)
                        echo "ユーザー名: $user"
                        echo "パスワード: $password"
                fi

		gpg --passphrase "gomen99" -e -r delta9kit@gmail.com -o testV.gpg testV2.txt
                rm testV2.txt


        elif [ "$operation" = "Exit" ]; then
                echo "Thank you!"
        else
                echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"


        fi

done





