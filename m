From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 04/12] pwm: clps711x: Cast period to u32 before use as divisor
Date: Fri, 20 Mar 2020 18:11:42 +0100
Message-ID: <CAK8P3a0ueOXLFPd_C4nbqHwEmVOa5eFfSivbsMPKNCmjMiWF1Q@mail.gmail.com>
References: <cover.1584667964.git.gurus@codeaurora.org> <3dc95ebc6539066cc58bc44c0e6e53ac979fe9a9.1584667964.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51599 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTRMB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 13:12:01 -0400
In-Reply-To: <3dc95ebc6539066cc58bc44c0e6e53ac979fe9a9.1584667964.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>

On Fri, Mar 20, 2020 at 2:41 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by typecasting it to u32.
>
> Also, since the dividend is still a 32-bit number, any divisor greater
> than UINT_MAX will cause the quotient to be zero, so return 0 in that
> case to efficiently skip the division.
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
