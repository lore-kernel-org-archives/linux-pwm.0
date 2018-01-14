From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] pwm: lpss-platform: Cleanly exit probe on boards without
 resources
Date: Sun, 14 Jan 2018 20:58:51 +0100
Message-ID: <bc345627-cbe2-8f59-18ca-82ed21871dbe@redhat.com>
References: <20180112113802.3888-1-hdegoede@redhat.com>
 <1515762291.7000.947.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37122 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeANT6z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Jan 2018 14:58:55 -0500
Received: by mail-wm0-f66.google.com with SMTP id f140so20691116wmd.2
        for <linux-pwm@vger.kernel.org>; Sun, 14 Jan 2018 11:58:54 -0800 (PST)
In-Reply-To: <1515762291.7000.947.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi,

On 12-01-18 14:04, Andy Shevchenko wrote:
> +Cc: Mika
> 
> On Fri, 2018-01-12 at 12:38 +0100, Hans de Goede wrote:
>> Some boards which do not use the pwm-controller have an empty or
>> invalid
>> resource-table in ACPI the for pwm-controller. Currently this causes
>> these
>> error messages to get logged:
>> [    3.281966] pwm-lpss 80862288:00: invalid resource
>> [    3.287098] pwm-lpss: probe of 80862288:00 failed with error -22
>>
>> This commit silences these error messages on these boards by cleanly
>> exiting pwm_lpss_probe_platform() if there is no memory resource.
>>
> 
> I don't see anything wrong with message per se.

Given all the effort distros have done with splash-screens to give
users a nice clean boot experience, we really want dmesg --level=err
to not print anything unless there is a real problem with either the
hardware or the kernel.

(Note that plymouth will drop back to text-mode when kernel errors
do show up.)

>> +
>> +	/*
>> +	 * Some boards which don't use the pwm controller have an
>> empty
>> +	 * resources table, so if we cannot get the resource, return
>> -ENODEV.
>> +	 */
>>   	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!r)
>> +		return -ENODEV;
> 
> But this one looks like a quirk for some platforms when other can
> survive without.

Right, this is something platform specific, but on platforms which
have a proper resource for the PWM this patch is a no-op, so there
is no need to do a quirk table for this, we can just silence the
error and be done with it.

> Can we actually check this in acpi_lpss.c and prevent platform device
> registration at all?

That is a good idea, it was not entirely trivial to achieve this
but I've come up with a patch which does that. If that is deemed
acceptable then we can go with that patch instead.

Regards,

Hans
