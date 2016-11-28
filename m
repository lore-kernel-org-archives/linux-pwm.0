From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] pwm: meson: Fix missing spin_lock_init
Date: Mon, 28 Nov 2016 10:28:45 +0800
Message-ID: <CAFRkauCBWiPTjrvgjsSvFU2p6FzYLMcy5UmVOeqDOm-Fpnu1CA@mail.gmail.com>
References: <1473472549-20140-1-git-send-email-axel.lin@ingics.com> <20161021071206.GB2670@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36521 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbcK1C2r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 27 Nov 2016 21:28:47 -0500
Received: by mail-qt0-f193.google.com with SMTP id n34so10008120qtb.3
        for <linux-pwm@vger.kernel.org>; Sun, 27 Nov 2016 18:28:46 -0800 (PST)
In-Reply-To: <20161021071206.GB2670@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org

2016-10-21 15:12 GMT+08:00 Thierry Reding <thierry.reding@gmail.com>:
> On Sat, Sep 10, 2016 at 09:55:49AM +0800, Axel Lin wrote:
>> The driver uses the spin_lock but not initialize it, fix it.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>  drivers/pwm/pwm-meson.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> Applied to for-4.9/fixes.
Hi Thierry,
I still don't find this fix in linux-next?

Regards,
Axel
