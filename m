From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
Date: Tue, 6 Sep 2016 12:04:38 +0200
Message-ID: <20160906100438.GE15644@ulmo.ba.sec>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
 <20160905090052.GG3532@ulmo.ba.sec>
 <bd7ea1db-d8f9-f075-14ef-732d9bb65e77@baylibre.com>
 <20160906090749.GA15644@ulmo.ba.sec>
 <a43f6e6e-05f6-cefe-451d-528588b85a8c@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35807 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755583AbcIFKEn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Sep 2016 06:04:43 -0400
Content-Disposition: inline
In-Reply-To: <a43f6e6e-05f6-cefe-451d-528588b85a8c@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: carlo@caione.org, khilman@baylibre.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2016 at 11:14:45AM +0200, Neil Armstrong wrote:
> On 09/06/2016 11:07 AM, Thierry Reding wrote:
> > On Tue, Sep 06, 2016 at 10:36:49AM +0200, Neil Armstrong wrote:
> >> Hi Thierry,
> >>
> [...]
> >=20
> >>
> >> The second bug is in probe(), I understand the point to allocate
> >> dynamically the channels and attach them to each pwm chip, but when
> >> calling meson_pwm_init_channels() we get an OOPS because
> >> meson->chip.pwms[i] are allocated in pwmchip_add(). Moving
> >> meson_pwm_init_channels() would fix this, but in case of a clk
> >> PROBE_DEFER, we would need to remove back the pwmchip, which is a
> >> quite a bad design decision....
> >=20
> > Ah yes... that one again. I remember running into that a while ago with
> > some other driver. To be honest, I think that's a short-coming of the
> > PWM subsystem and the fix would be for PWM chip registration to be split
> > into two parts: pwm_chip_init() and pwm_chip_add(). That way, a chip
> > would be initialized using pwm_chip_init() where the pwms array would be
> > allocated, and pwm_chip_add() would register the chip with the system.
> >=20
> > Currently a few drivers might be vulnerable to a race condition between
> > registration and implementation (i.e. PWM channels aren't fully set up
> > when they are exposed to users and sysfs).
> >=20
> >> The smartest fix I found was to allocate channels in probe, init them
> >> them attach them after pwmchip_add():
> >>
> [...]
>=20
> >=20
> > That's the race I was talking about above. I suppose it's not too big an
> > issue since other drivers seem to manage, so I'm going to merge your
> > fixed driver.
>=20
> ok thanks !

I've made a few tiny changes (reg -> offset, temporary variable to track
&channels[i], ...) and pushed it all out. Hopefully that now fixes any
of the remaining issues.

> > Unless you feel like taking a stab at the pwm_chip_init()/pwm_chip_add()
> > split, in which case your driver would be the first to be race-free. =
=3D)
>=20
> Having he driver upstream is a priority, but having it completely
> race-free would be great! I'll be happy to collaborate to a race-free
> pwmchip probe somehow !

Fair enough. I'll do some prototyping and keep you in the loop if I come
up with something that I think will do.

Thierry

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzpS0AAoJEN0jrNd/PrOhxR4P/10WuSB2yGoUA4ZitboaQW97
itnVPSFW1ijmoZRBvXanf8trwSGyVpq6WE1iycKHxoT1HdNpRtZhazca+9oQmNZL
xRxVgx4qtFE3K8ljWXuyzmKVUz14LpbWBOZJvOkL792XeO3Ity6ZT8igcNdrLFBk
GYtYI0tUlppk4oWQOzt+0G4+sxDrWhgeT1++xxGrz5H2CUC9rSyJc3cbg6vVoZQk
qceYMgfZfMp74TvpEwnG4LMlMdlrt2r/zV7/YFTw7u5o8QShR9zbU/TBb4g3DkMV
Jkx+vIf+5IZKs/jG+t/5TPoFmYLg8LKnn6hud7ovB06u/0UqCtxNuR3ZtgIsqScG
IWc5N79ZuzlztFAboLPytz/7B3RKIHnsmwEwalX1QBjPRZsgRKO0CWLrsRqvqF2T
pPWuRTc5jno2eH4UGqwXJ5xnr9gkJd4bVxV0l1BhSqKncdDcOYVVuJXjrMf1mPOH
ATmbMvQHiX6fKn/kMnmtH43rmM+CvAeapvle95Bae03U3ATo4FRq4JXT4Gm2Nv7m
L6C2zP4orXouMeKKGYT+NpdpSoEqISgYMAPkVfj/MAzsCILkjNoQAx07dZwWpuEO
IA1NRC8GTW/bITzpYfmVZ/ToV5WPOwGTqb4FucYzfJQEGQQCeto4amNOUqUc0wQ5
RlJkeAKeQVjvYZy7X0Bn
=uwR/
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
