From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/2] pwm: lpss: platform: Save/restore the ctrl
 register over a suspend/resume
Date: Mon, 14 May 2018 15:08:32 +0100
Message-ID: <fc46e2ab-13c6-4dfd-6539-703acec5555a@redhat.com>
References: <20180426121024.22023-1-hdegoede@redhat.com>
 <2943907.WSHDcS9sfS@aspire.rjw.lan> <20180514115032.GF18312@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180514115032.GF18312@ulmo>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On 05/14/2018 12:50 PM, Thierry Reding wrote:
> On Thu, May 10, 2018 at 05:25:10PM +0200, Rafael J. Wysocki wrote:
>> On Thursday, April 26, 2018 2:10:23 PM CEST Hans de Goede wrote:
>>> On some devices the contents of the ctrl register get lost over a
>>> suspend/resume and the PWM comes back up disabled after the resume.
>>>
>>> This is seen on some Bay Trail devices with the PWM in ACPI enumerated
>>> mode, so it shows up as a platform device instead of a PCI device.
>>>
>>> If we still think it is enabled and then try to change the duty-cycle
>>> after this, we end up with a "PWM_SW_UPDATE was not cleared" error and
>>> the PWM is stuck in that state from then on.
>>>
>>> This commit adds suspend and resume pm callbacks to the pwm-lpss-platform
>>> code, which save/restore the ctrl register over a suspend/resume, fixing
>>> this.
>>>
>>> Note that:
>>>
>>> 1) There is no need to do this over a runtime suspend, since we
>>> only runtime suspend when disabled and then we properly set the enable
>>> bit and reprogram the timings when we re-enable the PWM.
>>>
>>> 2) This may be happening on more systems then we realize, but has been
>>> covered up sofar by a bug in the acpi-lpss.c code which was save/restoring
>>> the regular device registers instead of the lpss private registers due to
>>> lpss_device_desc.prv_offset not being set. This is fixed by a later patch
>>> in this series.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Andy, Thierry, any comments or concerns regarding this series?
> 
> Hans said in the cover letter of the first version of this series that
> he preferred to merge both patches through the PWM tree because of the
> dependency. So I'm waiting for an Acked-by from you on the ACPI bits.

The other way around (both through ACPI) would work too, but yes it
would be good to keep them together,

Regards,

Hans
