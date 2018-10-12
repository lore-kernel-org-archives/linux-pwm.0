Return-Path: <hdegoede@redhat.com>
Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH v4 1/3] ACPI / PM: Export acpi_device_get_power() for use
 by modular build drivers
References: <20181011161444.328-1-hdegoede@redhat.com>
 <20181011161444.328-2-hdegoede@redhat.com>
 <3023968.j6vFC9EAcd@aspire.rjw.lan>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <908aec7b-030e-8cd0-14cf-59ec58bb5a64@redhat.com>
Date: Fri, 12 Oct 2018 11:29:42 +0200
MIME-Version: 1.0
In-Reply-To: <3023968.j6vFC9EAcd@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

On 11-10-18 22:37, Rafael J. Wysocki wrote:
> On Thursday, October 11, 2018 6:14:42 PM CEST Hans de Goede wrote:
>> Export acpi_device_get_power() for use by modular build drivers.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v4:
>> -New patch in v4 of this patch-set
>> ---
>>   drivers/acpi/device_pm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>> index a7c2673ffd36..824ae985ad93 100644
>> --- a/drivers/acpi/device_pm.c
>> +++ b/drivers/acpi/device_pm.c
>> @@ -126,6 +126,7 @@ int acpi_device_get_power(struct acpi_device *device, int *state)
>>   
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(acpi_device_get_power);
>>   
>>   static int acpi_dev_pm_explicit_set(struct acpi_device *adev, int state)
>>   {
>>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Does this mean that you are ok with taking this patch
upstream through Thierry's PWM tree ?

Thierry, do you want me to resend the latest version of all my
outstanding PWM LPSS patches as a single series?

Regards,

Hans
