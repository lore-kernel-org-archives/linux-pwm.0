From: David Hsu <davidhsu@google.com>
Subject: Re: [PATCH] pwm: Create device class for pwm channels
Date: Fri, 24 Jun 2016 13:54:33 -0700
Message-ID: <CAH7o3i7DduVSW4C-zZgfTiKcqbMAHS5cf5T-R8YyOVz7NnKXZQ@mail.gmail.com>
References: <20160615021204.GA11507@kroah.com> <20160615143720.GA23483@ulmo.ba.sec>
 <CAH7o3i6o2489ArgLRjhgv6uS+=RFq-dby9zc9vSMfDiQ62o86g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34159 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbcFXUyf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jun 2016 16:54:35 -0400
Received: by mail-qk0-f180.google.com with SMTP id t127so160320191qkf.1
        for <linux-pwm@vger.kernel.org>; Fri, 24 Jun 2016 13:54:35 -0700 (PDT)
In-Reply-To: <CAH7o3i6o2489ArgLRjhgv6uS+=RFq-dby9zc9vSMfDiQ62o86g@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 15, 2016 at 4:52 PM, David Hsu <davidhsu@google.com> wrote:
> On Wed, Jun 15, 2016 at 7:37 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
>> On Tue, Jun 14, 2016 at 07:12:04PM -0700, Greg KH wrote:
>>> From: David Hsu <davidhsu@google.com>
>>>
>>> Pwm channels don't send uevents when exported, this change adds the
>>> channels to a pwm class and set their device type to pwm_channel so
>>> uevents are sent.
>>>
>>> To do this properly, the device names need to change to uniquely
>>> identify a channel.  This change is from pwmN to pwm-(chip->base):N
>>>
>>> Signed-off-by: David Hsu <davidhsu@google.com>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>  Documentation/pwm.txt |    6 ++++--
>>>  drivers/pwm/sysfs.c   |   15 ++++++++++++---
>>>  2 files changed, 16 insertions(+), 5 deletions(-)
>>>
>>> Note, this patch came from David with his work on a system that has
>>> dynamic PWM devices and channels, and we needed some way to tell
>>> userspace what is going on when they are added or removed.  If anyone
>>> knows any other way of doing this that does not involve changing the pwm
>>> names, please let us know.
>>
>> Is it truly PWM channels that dynamically appear and disappear? I'd be
>> interested in how that's achieved, because there are probably other
>> issues that will manifest if you do that. Do you have a pointer to the
>> work that David's been undertaking? Generally some more context on the
>> use-case would be helpful here.
>
> Only PWM devices are dynamic, the number of channels exposed by
> devices do not change after they've been added to the system.
>
>>
>> Also I'd prefer if this avoided using chip->base here, because it exists
>> purely for legacy purposes and is supposed to go away eventually.
>>
>> Thierry
>
> Would using dev_name(parent) be an acceptable alternative?

Ping! Any comments on the above?

Thanks,
David
