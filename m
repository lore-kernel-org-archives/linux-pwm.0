Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:54705
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfE1IJW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 May 2019 04:09:22 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 28 May 2019 08:09:17 +0000
Message-ID: <OSAPR01MB3089DB21780B1236507E10D3D81E0@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1558923757-9843-1-git-send-email-cv-dong@jinso.co.jp>
 <20190527141741.GC7202@ulmo>
In-Reply-To: <20190527141741.GC7202@ulmo>
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH v5] pwm: renesas-tpu: Add suspend/resume function
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "broonie@kernel.org" <broonie@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, hideo inayoshi <h-inayoshi@jinso.co.jp>, "na-hoan@jinso.co.jp" <na-hoan@jinso.co.jp>, Cao Van Dong <cv-dong@jinso.co.jp>

Hi Thierry,

> From: Thierry Reding, Sent: Monday, May 27, 2019 11:18 PM
<snip>
> This has been discussed before, but this really shouldn't be done in the
> PWM driver. Consumers should really be reconfiguring the PWM upon resume
> as appropriate. This is the only way to ensure that everything is
> resumed in the proper order.
>=20
> Most, if not all, consumers already implement suspend/resume that way.
> sysfs is the only one that I'm aware of that doesn't.
>=20
> Since you've been using sysfs to test this, things are slightly more
> complicated (i.e. we don't have a consumer driver in the conventional
> way). However, you should be able to solve this by implementing
> dev_pm_ops for the pwm_class.

Thank you for your coment! I'm interesting about implementing dev_pm_ops
for the pwm_class. This is because you talked related things on other
pwm driver (pwm-rcar) on the following email thread.
https://marc.info/?l=3Dlinux-renesas-soc&m=3D155169831832176&w=3D2

So, I'll try to implement it and tested on the pwm-rcar driver.

Best regards,
Yoshihiro Shimoda
