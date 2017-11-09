From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFT] pwm: stmpe: Fix wrong register offset for hwpwm=2 case
Date: Thu, 9 Nov 2017 09:45:16 +0100
Message-ID: <CACRpkda1G635V3kNXzVcnUStB8tjCdHupf3PcR_t2H5ZX0OftQ@mail.gmail.com>
References: <20171107051853.14492-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:47616 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753577AbdKIIpR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Nov 2017 03:45:17 -0500
Received: by mail-it0-f48.google.com with SMTP id p138so10307816itp.2
        for <linux-pwm@vger.kernel.org>; Thu, 09 Nov 2017 00:45:17 -0800 (PST)
In-Reply-To: <20171107051853.14492-1-axel.lin@ingics.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>

On Tue, Nov 7, 2017 at 6:18 AM, Axel Lin <axel.lin@ingics.com> wrote:

> Fix trivial copy/paste bug.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Linus,
> I don't have this h/w to test.
> Appreciate if you can review and test this patch.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This is an obvious copy/paste bug indeed.

Yours,
Linus Walleij
