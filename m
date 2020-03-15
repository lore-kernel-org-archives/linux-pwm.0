From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] pwm: meson: Fix confusing indentation
Date: Sun, 15 Mar 2020 13:21:40 +0100
Message-ID: <658d2096-8a2d-7cd0-b4fd-88f4516ac7a9@baylibre.com>
References: <20200314113524.23031-1-krzk@kernel.org>
 <20200314214347.dun6ith5zamaa3m6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52938 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgCOMV7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 15 Mar 2020 08:21:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so14624054wmo.2
        for <linux-pwm@vger.kernel.org>; Sun, 15 Mar 2020 05:21:58 -0700 (PDT)
In-Reply-To: <20200314214347.dun6ith5zamaa3m6@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de



Le 14/03/2020 à 22:43, Uwe Kleine-König a écrit :
> On Sat, Mar 14, 2020 at 12:35:24PM +0100, Krzysztof Kozlowski wrote:
>> Fix indentation of return block.  Smatch warning:
>>     drivers/pwm/pwm-meson.c:139 meson_pwm_request() warn: inconsistent indenting
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> This exists since commit 211ed630753d ("pwm: Add support for Meson PWM
> Controller") in 2016. Added Neil to Cc:.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Thanks
> Uwe
> 

Missing

Fixes: 211ed630753d ("pwm: Add support for Meson PWM Controller")

With that

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
