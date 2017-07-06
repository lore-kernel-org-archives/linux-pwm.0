From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/4] pwm-backlight: add support for pwm-delay-us
 property
Date: Thu, 6 Jul 2017 11:24:48 +0200
Message-ID: <20170706092448.GQ16144@ulmo.fritz.box>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
 <20170630112109.13785-2-enric.balletbo@collabora.com>
 <20170706080132.GL16144@ulmo.fritz.box>
 <20170706091231.GA6741@amd>
 <ac8bd991-be3c-c090-8e71-8f901b0a45a7@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dUqh8vgUBVXHzm9w"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33344 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdGFJYv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 05:24:51 -0400
Content-Disposition: inline
In-Reply-To: <ac8bd991-be3c-c090-8e71-8f901b0a45a7@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org, huang lin <hl@rock-chips.com>


--dUqh8vgUBVXHzm9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 10:17:18AM +0100, Daniel Thompson wrote:
> On 06/07/17 10:12, Pavel Machek wrote:
> > On Thu 2017-07-06 10:01:32, Thierry Reding wrote:
> > > On Fri, Jun 30, 2017 at 01:21:07PM +0200, Enric Balletbo i Serra wrot=
e:
> > > > From: huang lin <hl@rock-chips.com>
> > > >=20
> > > > Some panels (i.e. N116BGE-L41), in their power sequence specificati=
ons,
> > > > request a delay between set the PWM signal and enable the backlight=
 and
> > > > between clear the PWM signal and disable the backlight. Add support=
 for
> > > > the new pwm-delay-us property to meet the timing.
> > > >=20
> > > > Note that this patch inverts current sequence. Before this patch the
> > > > enable signal was set before the PWM signal and vice-versa on power=
 off.
> > > >=20
> > > > I assumed that this sequence was wrong, at least it is on different=
 panel
> > > > datasheets that I checked, so I inverted the sequence to follow:
> > > >=20
> > > >    On power on, set the PWM signal, wait, and set the LED_EN signal.
> > > >    On power off, clear the LED_EN signal, wait, and stop the PWM si=
gnal.
> > >=20
> > > I think this should be two separate patches to make it easier to reve=
rt
> > > the inverted sequence should it prove to regress on other panels.
> >=20
> > Don't make this overly complex. This is trivial. No need to split it
> > into more patches.
>=20
> Agree. IMHO getting the code that reads the (optional) new parameter corr=
ect
> is the best way to manage risk of regression since in most cases the delay
> will be skipped anyway.

The potential regression that I'm referring to would be caused by
inversing the sequence (GPIO enable -> PWM enable). That's completely
unrelated to the delays introduced by this patch. Many boards use this
driver and they've been running with the old sequence for many years.
Granted, it's fairly unlikely to regress, but it's still a possibility.

Given that both changes are logically separate, I think separate patches
are totally appropriate. I also don't think that this would overly
complicate things.

Thierry

--dUqh8vgUBVXHzm9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlleAd8ACgkQ3SOs138+
s6FvpQ/5AZkRMQo/qVT4t08hyAsTpydmq5DyuYGPj8N4lItKGeoadzKM8Byn+k+O
sf8AXPZD0S4K7OEY8Ecyd+IB4HHdL8rH+Lt0XckOblcUP/vgP9rzuJNrot7iMeVH
mYuuZ6x35E31vK5kT0ZXgx/wK0b2jG1508H4ojLJdoxvbamQO9Oz6y6+CVJc8rAI
vnApmAP/dxfzjCDwVRp7Iyep418n5zOhNU2Y/hc2DSeRhYQNkx4mnv/JUUoZyLjA
gsjujplSruujmaZmU2lPJy+JTGOIUq2k7oD/Z98SwBl9bxhKOn/Kj7Y0UQ90YfCb
fS10e6T+zHxP+0DmynekaZGrUuexlx2oRnPtdVYYsd9KATOOQ9vbTc3JrrOYarO5
uGUZZjdAOmWE0vKDCV1huw9w2B2P5xmom1cN/c7kClGSDvmCwDYitF89ejdIs/bM
Og5omTa7tJ6pWQ2Sc1BU68Rt2DXh/bAtVsSHEeheouf1wKiXLJtfW9l/uhJjrPrK
S0P4w//X3iVC/+qC4q6elVqlBmK6uYQYpNHTENbvK0wXuETmDB+jouYLSun6l3Mv
idj2BL6Os2K2xbPyTBIo29pUXW/V7YyJ96VnWadldATCvs6BTEHEvlicbfiw/oN6
nBOWud/a6kPIanBhReARhVkftt/idgEGDVDfFst+N6CUImmlj7o=
=SG24
-----END PGP SIGNATURE-----

--dUqh8vgUBVXHzm9w--
