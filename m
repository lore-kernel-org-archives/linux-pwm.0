Return-Path: <hdegoede@redhat.com>
Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] pwm: lpss: Check PWM powerstate after resume on
 Cherry Trail devices
References: <20180911173050.2374-1-hdegoede@redhat.com>
 <20180924091841.GG15943@smile.fi.intel.com>
 <02750104-3029-13df-7506-95416a89d68b@redhat.com>
 <2073706.oZqG2eVWq3@aspire.rjw.lan>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <db4f6771-9ce3-9793-a2e4-b317909cd06b@redhat.com>
Date: Sat, 6 Oct 2018 10:55:41 +0200
MIME-Version: 1.0
In-Reply-To: <2073706.oZqG2eVWq3@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

On 03-10-18 11:22, Rafael J. Wysocki wrote:
> On Monday, September 24, 2018 11:40:14 AM CEST Hans de Goede wrote:
>> Hi,
>>
>> On 24-09-18 11:18, Andy Shevchenko wrote:
>>> On Mon, Sep 24, 2018 at 11:10:28AM +0200, Hans de Goede wrote:
>>>
>>>>>> +	/* The PWM may be turned on by AML code, update our state to match */
>>>>>> +	if (pm_runtime_suspended(dev) && lpwm->info->check_power_on_resume) {
>>>>>
>>>>>> +		status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_PSC",
>>>>>> +					       NULL, &psc);
>>>>>
>>>>> AFAIU this is a standard power source method for ACPI, shouldn't ACPI core take
>>>>> care of being in sync?
>>>>
>>>> This is not about ACPI power-resources, this is about the power state (D0 or D3)
>>>> of the device itself. The ACPI core does not expect the state of devices to
>>>> magically change underneath it when using s2idle, since then everything is
>>>> under the kernel's control. But the _PS0 method of the GPU messing with the PWM
>>>> controller (hurray for firmware) messes things up.
>>>
>>> What I mean is shouldn't we care about this on a ACPI core level to be sure
>>> that states are kept in sync on OS level?
>>
>> The ACPI / pm core does care about this when doing a firmware supported suspend/resume
>> (so going to regular S3) because the firmware can then make all sort of changes
>> to the device state.
>>
>> But with s2idle the kernel is fully in control and we never hand control over to the
>> firmware, so checking the device state then should not be necessary and is a somewhat
>> expensive operation (esp. to do on all devices), while one of the advantages of s2idle
>> is supposed to be shorter suspend/resume times.
>>
>> IOW for s2idle it is undesirable for the core to check the power-state of all
>> devices after a resume, since it simply should not have changed, with the PWM
>> device being a nasty exception because of the _PS0 method for *another* device
>> mucking with it.
>>
>> Anyways lets see what Rafael has to say about this.
> 
> It is OK to check the device power state in the driver in that case IMO,
> although I would add a comment explaining why it is needed to the code.

There already are comments:

drivers/pwm/pwm-lpss.h

         /* Some devices have AML code messing with the state underneath us */
         bool check_power_on_resume;

drivers/pwm/pwm-lpss-platform.c: pwm_lpss_complete():

         /* The PWM may be turned on by AML code, update our state to match */
         if (pm_runtime_suspended(dev) && lpwm->info->check_power_on_resume) {
                 status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_PSC",
                                                NULL, &psc);
                 if (ACPI_SUCCESS(status) && psc == ACPI_STATE_D0) {
                         pm_runtime_disable(dev);
                         pm_runtime_set_active(dev);
                         pm_runtime_enable(dev);
                 }
         }
	
Or do you want the comment to go into more detail ?

> Also, why don't you use acpi_device_get_power() instead of evaluating
> _PSC directly?  It should make no difference if there are no power
> resources, should it?

2 reasons:

1) I really want to check the D3 enabled bit from the devices configs regs,
as that is what block S0ix, this is exactly what the _PSC method does

2) acpi_device_get_power() is not exported to modules

> In addition, I would disable runtime PM before checking the power state,
> then check it, set the correct runtime PM status and re-enable runtime PM.

Ok I will send a v2 with this changed.

Regards,

Hans
