From: David Hsu <davidhsu@google.com>
Subject: Re: [PATCH] pwm: Unexport children before chip removal
Date: Wed, 10 Aug 2016 15:54:19 -0700
Message-ID: <CAH7o3i44Fgtoii=g4NSkXEK2_44KXLreuDAAb-7g1-OS2XxPJA@mail.gmail.com>
References: <1470779866-74776-1-git-send-email-davidhsu@google.com> <20160810084957.GC12080@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33390 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbcHJWyU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Aug 2016 18:54:20 -0400
Received: by mail-io0-f177.google.com with SMTP id 38so55727116iol.0
        for <linux-pwm@vger.kernel.org>; Wed, 10 Aug 2016 15:54:20 -0700 (PDT)
In-Reply-To: <20160810084957.GC12080@kroah.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sandeep Patil <sspatil@google.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 10, 2016 at 1:49 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Aug 09, 2016 at 02:57:46PM -0700, David Hsu wrote:
>> Exported pwm channels aren't removed before the pwmchip and are
>> leaked. This results in invalid sysfs files. This fix removes
>> all exported pwm channels before chip removal.
>>
>> Signed-off-by: David Hsu <davidhsu@google.com>
>> ---
>>  drivers/pwm/core.c  |  2 ++
>>  drivers/pwm/sysfs.c | 18 ++++++++++++++++++
>>  include/linux/pwm.h |  5 +++++
>>  3 files changed, 25 insertions(+)
>
> Should this also go to the stable kernel releases?
>

Yes, this should go into stable.

Thanks,
David

> thanks,
>
> greg k-h
