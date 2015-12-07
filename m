From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v5] pwm-backlight: Avoid backlight flicker when probed
 from DT
Date: Mon, 7 Dec 2015 12:20:26 +0800
Message-ID: <CAGS+omCD3MLB+hf4R1aD+YZuB4SV8nu71oAm6V_bkfoE2im49A@mail.gmail.com>
References: <1447866745-21567-1-git-send-email-p.zabel@pengutronix.de> <20151124162658.GJ807@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34443 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246AbbLGEUq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Dec 2015 23:20:46 -0500
Received: by vkbs1 with SMTP id s1so95595805vkb.1
        for <linux-pwm@vger.kernel.org>; Sun, 06 Dec 2015 20:20:46 -0800 (PST)
In-Reply-To: <20151124162658.GJ807@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, YH Huang <yh.huang@mediatek.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sasha Hauer <kernel@pengutronix.de>

Hi Lee,

On Wed, Nov 25, 2015 at 12:26 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 18 Nov 2015, Philipp Zabel wrote:
>
>> If the driver is probed from the device tree, and there is a phandle
>> property set on it, and the enable GPIO is already configured as output,
>> and the backlight is currently disabled, keep it disabled.
>> If all these conditions are met, assume there will be some other driver
>> that can enable the backlight at the appropriate time.
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  - Rebased onto v4.4-rc1
>>  - Added Heiko's Tested-by
>> ---
>>  drivers/video/backlight/pwm_bl.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> Applied, thanks.

Hmm, where was this applied?  I do not see it in:
 * v4.4-rc4
 * linux-next next-20151203 (dcccebc - Add linux-next specific files
for 20151203)

Nor do I see it in any branch in:
 * git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
Is this the right git?
By the way this repository has a git tag called "HEAD", which is a bit
annoying since every time I "git remote update" from here, git gets
confused until I manually delete it (git tag -d HEAD).

Thanks,
-Dan
