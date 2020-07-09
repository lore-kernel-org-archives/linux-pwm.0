From: Paul Barker <pbarker@konsulko.com>
Subject: Re: [PATCH] ARM: dts: imx: default to #pwm-cells = <3> in the SoC
 dtsi files
Date: Thu, 9 Jul 2020 18:30:31 +0100
Message-ID: <CAM9ZRVt8V9mPwAtQ3pvPqGc-Zuxs-SkcoSNk49JipwvERByGdw@mail.gmail.com>
References: <20200709144527.23528-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGIRan (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 13:30:43 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB18C08C5CE
        for <linux-pwm@vger.kernel.org>; Thu,  9 Jul 2020 10:30:43 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h13so2274810otr.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jul 2020 10:30:43 -0700 (PDT)
In-Reply-To: <20200709144527.23528-1-uwe@kleine-koenig.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>

On Thu, 9 Jul 2020 at 15:45, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org> =
wrote:
>
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> The imx-pwm driver supports 3 cells and this is the more flexible setting=
.
> So use it by default and overwrite it back to two for the files that
> reference the PWMs with just 2 cells to minimize changes.
>
> This allows to drop explicit setting to 3 cells for the boards that alrea=
dy
> depend on this.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> this picks up an old mail thread where Paul Barker started to work on
> this in March. He got some feedback but didn't come up with a new
> approach.
>
> Compared to his patch (Message-Id:
> 20200309145558.16098-1-pbarker@konsulko.com) I overwrite back to
> #pwm-cells =3D <2> in the board .dts files to minimize changes there.
>
> Best regards
> Uwe

Thanks for picking this up Uwe, I must admit it fell off my todo list
due to the coronavirus situation.

Is there a reason why imx23.dtsi, imx28.dtsi and imx51.dtsi have not
been changed?

--=20
Paul Barker
Konsulko Group
