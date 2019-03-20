Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34562 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCTPKY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Mar 2019 11:10:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id a16so2313606edn.1
        for <linux-pwm@vger.kernel.org>; Wed, 20 Mar 2019 08:10:23 -0700 (PDT)
Reply-To: bdv.integrator@gmail.com
References: <9e1828a2-e3ae-853b-6a1c-010d1aa2f670@gmail.com>
 <23dd220e-6929-502c-ae9f-9b6cc994985a@ysoft.com>
From: Bart De Vos <bdv.integrator@gmail.com>
Message-ID: <d350d6b0-841d-4331-9751-c128b6a86b6e@gmail.com>
Date: Wed, 20 Mar 2019 16:10:20 +0100
MIME-Version: 1.0
In-Reply-To: <23dd220e-6929-502c-ae9f-9b6cc994985a@ysoft.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: issue with (parent)class for exported channels in sysfs
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>, gottfried.haider@gmail.com
Cc: thierry.reding@gmail.com, hsweeten@visionengravers.com, linux-pwm@vger.kernel.org

Okay,

I saw in the meantime it has been solved in mainstream, and could easily 
backport that part.

but ...

Your mentioning on versions confuses me: I'm running 4.19.28, I would 
expect that commit 552c02e3e7cf is part of that.

Anyhow, issue solved, thanks for your quick reply.

Kr,
Bart.

On 03/20/2019 04:03 PM, Michal Vokáč wrote:
> On 20. 03. 19 15:48, Bart De Vos wrote:
>> Hi,
>>
>> The commit below causes the following side-effect:
>>
>> symlinks are created for each individual pwm, as follows (conceptually):
>>
>> /sys/class/pwm/pwm0 -> /sys/class/pwm/pwmchip0/pwm0
>>
>> This fails for exporting the next pwmchip, since pwmchips enumerate 
>> their channels from 0 ... <npwm>.
>>
>> I can work around it by putting the assignment of the class around a 
>> CONFIG_PWM_PARENT_CLASS, since I don't use uevents on my embedded 
>> system for pwms.
>>
>> Yet I believe both use-cases should be possible,
>> i.e. set the right properties to support proper uevents
>> _AND_
>> export multiple channels from multiple chips over sysfs.
>>
>> What are your thoughts on a good way forward?
>>
>> Thanks in advance for your feedback.
> 
> Hello Bart,
> 
> What kernel version you use? It seems it must be something older than v4.19
> as this issue has already been fixed and the commit you reffer to has been
> reverted in v4.19-rc1. See:
> 
> See commit 552c02e3e7cf ("pwm: Send a uevent on the pwmchip device upon
> channel sysfs (un)export") and commit c289d6625237 ("Revert "pwm: Set class
> for exported channels in sysfs"").
> 
> So a good way forward is to use more recent kernel :)
> 
> All the best,
> Michal
> 
>>
>> commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00
>> Author: Gottfried Haider <gottfried.haider@gmail.com>
>> Date:   Tue Sep 26 11:59:51 2017 +0000
>>
>>      pwm: Set class for exported channels in sysfs
>>
>>      Notifications for devices without bus or class set get dropped by
>>      dev_uevent_filter(). Adding the class to the exported child matches
>>      what the GPIO subsystem is doing.
>>
>>      With this change exporting a channel triggers a udev event, which
>>      gives userspace a chance to fixup permissions and makes it possible
>>      for non-root users to make use of the PWM subsystem.
>>
>>      Signed-off-by: Gottfried Haider <gottfried.haider@gmail.com>
>>      CC: Thierry Reding <thierry.reding@gmail.com>
>>      CC: H Hartley Sweeten <hsweeten@visionengravers.com>
>>      CC: linux-pwm@vger.kernel.org
>>      CC: linux-arm-kernel@lists.infradead.org
>>      CC: linux-rpi-kernel@lists.infradead.org
>>      Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>>
>> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
>> index a813239300c3..83f2b0b15712 100644
>> --- a/drivers/pwm/sysfs.c
>> +++ b/drivers/pwm/sysfs.c
>> @@ -263,6 +263,7 @@ static int pwm_export_child(struct device *parent, 
>> struct pwm_device *pwm)
>>          export->pwm = pwm;
>>          mutex_init(&export->lock);
>>
>> +       export->child.class = parent->class;
>>          export->child.release = pwm_export_release;
>>          export->child.parent = parent;
>>          export->child.devt = MKDEV(0, 0);
> 
