From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] [linux-next] pwm: lpss: fix const qualifier discard
 warning
Date: Wed, 07 May 2014 10:48:53 +0100
Message-ID: <1399456133.2458.52.camel@acox1-desk.ger.corp.intel.com>
References: <1399044179-17912-1-git-send-email-mq@suse.cz>
	 <20140507084137.GD6362@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11280 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbaEGJs5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 7 May 2014 05:48:57 -0400
In-Reply-To: <20140507084137.GD6362@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jan Moskyto Matejka <mq@suse.cz>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2014-05-07 at 10:41 +0200, Thierry Reding wrote:
> On Fri, May 02, 2014 at 05:22:59PM +0200, Jan Moskyto Matejka wrote:
> > Fixing this warning:
> > drivers/pwm/pwm-lpss.c: In function =E2=80=98pwm_lpss_probe_pci=E2=80=
=99:
> > drivers/pwm/pwm-lpss.c:192:2: warning: passing argument 3 of =E2=80=
=98pwm_lpss_probe=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier f=
rom pointer target type [enabled by default]
> >   lpwm =3D pwm_lpss_probe(&pdev->dev, &pdev->resource[0], info);
> >   ^
> > drivers/pwm/pwm-lpss.c:130:30: note: expected =E2=80=98struct pwm_l=
pss_boardinfo *=E2=80=99 but argument is of type =E2=80=98const struct =
pwm_lpss_boardinfo *=E2=80=99
> >  static struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,
> >=20
> > That warning was introduced in commit 093e00bb3f82f3c67e2d1682e316f=
c012bcd0d92
> > ("pwm: lpss: Add support for PCI devices").
> >=20
> > Signed-off-by: Jan Moskyto Matejka <mq@suse.cz>
> > ---
> >  drivers/pwm/pwm-lpss.c | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> This was reported over a week ago by the kbuild test robot and I've h=
ad
> fixes for this (and an additional sparse warning) in my tree for a wh=
ile
> now. Interestingly everybody at Intel seems to have forgotten about t=
his
> driver after their patches got merged since nobody cared to respond.

No - like everyone else we're all juggling multiple things. Also
remember there have just been a bunch of public holidays on large parts
of the planet.

I did see Jan's email but I didn't realise it needed a response, it was
clearly and obviously correct.

Alan


