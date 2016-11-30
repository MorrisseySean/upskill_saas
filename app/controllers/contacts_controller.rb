class ContactsController < ApplicationController
    
    # GET request to /contact-us
    # Show new contact form
    def new
        @contact = Contact.new
    end
    
    # POST request /contacts
    def create
        # Mass assignment of form fields in to Contact object
        @contact = Contact.new(contact_params)
        # Save the contact to database
        if @contact.save
            # Store form fields in to local variables if successful
            name = params[:contact][:name]
            email = params[:contact][:email]
            comments = params[:contact][:comments]
            # Send variables to the ContactMailer and send email
            ContactMailer.contact_email(name, email, comments).deliver
            # Set success message and refresh contacts page
            flash[:success] = "Message sent! Thank you!"
            redirect_to new_contact_path
        else
            # If save fails, set error message and refresh contacts page
            flash[:danger] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        end
    end
    
    private
        # Use strong parameters to collect data and whitelist form data
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end