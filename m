Return-Path: <hdegoede@redhat.com>
Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH v4 1/3] ACPI / PM: Export acpi_device_get_power() for use
 by modular build drivers
References: <20181011161444.328-1-hdegoede@redhat.com>
 <20181011161444.328-2-hdegoede@redhat.com>
 <20181011171413.GO15943@smile.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <67e20df0-552f-c793-f08e-5853ac69f85f@redhat.com>
Date: Fri, 12 Oct 2018 11:31:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181011171413.GO15943@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

On 11-10-18 19:14, Andy Shevchenko wrote:
> On Thu, Oct 11, 2018 at 06:14:42PM +0200, Hans de Goede wrote:
>> Export acpi_device_get_power() for use by modular build drivers.
>>
> 
> non-GPL export is used to be consistent with setter counterpart, right?

Right.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks.

Regards,

Hans



> 
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
>> -- 
>> 2.19.0
>>
> 
