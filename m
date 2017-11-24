From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH RFT] pwm: stmpe: Fix wrong register offset for hwpwm=2 case
Date: Fri, 24 Nov 2017 17:10:14 +0800
Message-ID: <CAFRkauBhALFxedJ-4nBXpjBF9Sd-NW9bQrgwtHUbYjQ3yZGTCw@mail.gmail.com>
References: <20171107051853.14492-1-axel.lin@ingics.com> <CACRpkda1G635V3kNXzVcnUStB8tjCdHupf3PcR_t2H5ZX0OftQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:44416 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdKXJKQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Nov 2017 04:10:16 -0500
Received: by mail-wm0-f42.google.com with SMTP id r68so21163212wmr.3
        for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2017 01:10:15 -0800 (PST)
In-Reply-To: <CACRpkda1G635V3kNXzVcnUStB8tjCdHupf3PcR_t2H5ZX0OftQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>

2017-11-09 16:45 GMT+08:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Nov 7, 2017 at 6:18 AM, Axel Lin <axel.lin@ingics.com> wrote:
>
>> Fix trivial copy/paste bug.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>> Hi Linus,
>> I don't have this h/w to test.
>> Appreciate if you can review and test this patch.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Hi Thierry,
Seems this one is still not apply. Should I resend?

Thanks,
Axel
