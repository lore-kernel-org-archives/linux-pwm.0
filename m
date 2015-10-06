From: Olliver Schinagl <oliver+list@schinagl.nl>
Subject: Re: [RFC] pwm: chip_data vs device_data
Date: Tue, 06 Oct 2015 10:21:34 +0200
Message-ID: <5613848E.2060800@schinagl.nl>
References: <56137655.40804@schinagl.nl> <20151006073856.GB18633@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151006073856.GB18633@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pwm@vger.kernel.org

Hey Thierry,

thans for your quick reply :)

On 06-10-15 09:38, Thierry Reding wrote:
> On Tue, Oct 06, 2015 at 09:20:53AM +0200, Olliver Schinagl wrote:
>> Hey Thierry, list,
>>
>> While working on something in the pwm framework, I noticed that the void
>> *data in the pwm_device struct is called chip_data. Why is it not called
>> device_data, since it is the data associated with a PWM device, rather then
>> the chip, and on that note, if it really is chip related data (thus covering
>> the whole chip, not just the single pwm device) why is there no chip_data in
>> pwm_chip?
> The reason for the name is that it's chip-specific data associated with
> a struct pwm_device. That is, a PWM chip implementation (i.e. driver)
> can use it to keep per-PWM data that's not in struct pwm_device itself.
Then I have to wrap my head around what is a chip and what is a device :)

To me, it seems that a chip can hold X number of pwm devices, and each 
pwm_device has a unique set of properties, duty, plarity, period. So it 
seems that some device specific data could go here as well, where i'm 
bad at examples now
>
>> Again, is this something worth my time to add a device_data and rename
>> chip_data?
> device_data would be redundant because it's already part of struct
> pwm_device. Plain data might be okay, but I like the chip_ prefix
> because it marks the data as being chip-specific data rather than
> generic.
well here i'd imagine the chip specific data (not allready in the struct).

I'll be subimtting my RFC work later this week after a little bit more 
work and will bring this up again :)

Olliver
>
> Thierry
