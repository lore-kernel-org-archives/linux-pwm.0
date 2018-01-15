From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / LPSS: Do not instiate a platform_dev for devs
 without a mmio resource
Date: Mon, 15 Jan 2018 09:42:48 +0100
Message-ID: <eaa39560-7386-4d24-756d-24ef97cb6392@redhat.com>
References: <20180114200148.11771-1-hdegoede@redhat.com>
 <CAJZ5v0iFwWB+3oooV+vZM99SQnUpA-kuYYaNQsre9e_T_UeBxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iFwWB+3oooV+vZM99SQnUpA-kuYYaNQsre9e_T_UeBxA@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On 15-01-18 00:36, Rafael J. Wysocki wrote:
> On Sun, Jan 14, 2018 at 9:01 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> acpi_lpss_create_device() skips handling LPSS devices which do not have
>> a mmio resources in their resource list (typically these devices are
>> disabled by the firmware). But since the LPSS code does not bind to the
>> device, acpi_bus_attach() ends up still creating a platform device for
>> it and the regular platform_driver for the ACPI HID still tries to bind
>> to it.
>>
>> This happens e.g. on some boards which do not use the pwm-controller
>> and have an empty or invalid resource-table for it. Currently this causes
>> these error messages to get logged:
>> [    3.281966] pwm-lpss 80862288:00: invalid resource
>> [    3.287098] pwm-lpss: probe of 80862288:00 failed with error -22
>>
>> This commit stops the undesirable creation of a platform_device for
>> disabled LPSS devices by setting pnp.type.platform_id to 0. Note that
>> acpi_scan_attach_handler() also sets pnp.type.platform_id to 0 when there
>> is a matching handler for the device and that handler has no attach
>> callback, so we simply behave as a handler without an attach function
>> in this case.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Does this fix new behavior or is it an old issue?

The problem this addresses is likely caused by the acpi_always_present
entry for the CHT 80862288 PWM devices in drivers/acpi/x86/utils.c.

The problem is that under Windows the Intel GPU driver has hardcoded
addresses for the PWM LPSS bits (or so I believe), rather then having
it as a separate device with a separate driver, so the CHT LPSS PWM
device's _STA returns 0 on all x86 devices which ship with Windows.

On most CHT laptops / tablets it is used to control the backlight
brightness so we do need the device under Linux, where we've a
separate PWM driver and we don't want to be hardcoding stuff like
this.

So we really cannot do without the acpi_always_present entry, and thus
need this extra check for devices where the pwm is actually unused
and disabled by the firmware.

Regards,

Hans

>> ---
>>   drivers/acpi/acpi_lpss.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
>> index 9cfe6b71078b..166a8e582d96 100644
>> --- a/drivers/acpi/acpi_lpss.c
>> +++ b/drivers/acpi/acpi_lpss.c
>> @@ -610,6 +610,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>>          acpi_dev_free_resource_list(&resource_list);
>>
>>          if (!pdata->mmio_base) {
>> +               /* Avoid acpi_bus_attach() instantiating a pdev for this dev. */
>> +               adev->pnp.type.platform_id = 0;
>>                  /* Skip the device, but continue the namespace scan. */
>>                  ret = 0;
>>                  goto err_out;
>> --
>> 2.14.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
