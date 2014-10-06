From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 0/2] mfd: add atmel-hlcdc driver
Date: Mon, 6 Oct 2014 17:23:51 +0100
Message-ID: <20141006162351.GA3848@lee--X1>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36068 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaJFQX7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Oct 2014 12:23:59 -0400
Received: by mail-ig0-f181.google.com with SMTP id r10so3038822igi.14
        for <linux-pwm@vger.kernel.org>; Mon, 06 Oct 2014 09:23:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Mon, 06 Oct 2014, Boris Brezillon wrote:
> As proposed in my last atmel-hlcdc series I have split the series in =
order
> to get the accepted parts merged.
>=20
> This series is the one all others depend on.
> Could you take it in your tree so that other maintainers can rely on =
the
> fact this part will be merged before other parts.
>=20
> Moreover, I know this is late, but can you include it in one of your =
3.18
> pull request as suggested by Thierry.
> If you can't, can you provide Thierry and Dave with a stable branch
> including this driver ?

It's too late for v3.18.  I stopped taking patches a couple of weeks
ago.  Looks like you still need a DT Ack too.

> Best Regards,
>=20
> Boris
>=20
> Boris Brezillon (2):
>   mfd: add atmel-hlcdc driver
>   mfd: add documentation for atmel-hlcdc DT bindings
>=20
>  .../devicetree/bindings/mfd/atmel-hlcdc.txt        |  51 +++++++++
>  drivers/mfd/Kconfig                                |   6 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/atmel-hlcdc.c                          | 122 +++++++++++=
++++++++++
>  include/linux/mfd/atmel-hlcdc.h                    |  85 +++++++++++=
+++
>  5 files changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc=
=2Etxt
>  create mode 100644 drivers/mfd/atmel-hlcdc.c
>  create mode 100644 include/linux/mfd/atmel-hlcdc.h
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
