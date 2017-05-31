From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 00/58] ARM: at91: rework Atmel TCB drivers
Date: Wed, 31 May 2017 08:34:00 +0200
Message-ID: <da7069d4-e5b3-f10f-0816-ff973195aff6@axentia.se>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ve1eur01on0128.outbound.protection.outlook.com ([104.47.1.128]:42478
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbdEaGeK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 31 May 2017 02:34:10 -0400
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Antoine Aubert <a.aubert@overkiz.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, Douglas Gilbert <dgilbert@interlog.com>, Fabio Porcedda <fabio.porcedda@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Gregory Hermant <gregory.hermant@calao-systems.com>, Joachim Eastwood <manabian@gmail.com>, linux-pwm@vger.kernel.org, Marek Vasut <marex@denx.de>, Martin Reimann <martin.reimann@egnite.de>, Raashid Muhammed <raashidmuhammed@zilogic.com>, Rob Herring <robh+dt@kernel.org>, Rodolfo Giometti <giometti@linux.it>, Sergio Tanzilli <tanzilli@acmesystems.it>, Thierry Reding <thierry.reding@gmail.com>

On 2017-05-30 23:50, Alexandre Belloni wrote:
> Hi,
> 
> This series reworks the Atmel Timer counter Block drivers. Those blocks
> each have 3 counters with 2 channels each and can be used for
> multiple functions:
>  - timers
>  - PWMs
>  - Quadrature decoders
>  - Stepper motor counters

I'd like to test this, but I have a hard time doing that since all I got
was this cover letter and a single DT-only patch.

I understand that you were reluctant to spam too many people with
dozens of patches, but perhaps the series can be fetched from
somewhere?

Cheers,
peda
