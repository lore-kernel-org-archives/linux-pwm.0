From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 11/12] ASoC: tegra: register dependency
 parser for firmware nodes
Date: Fri, 17 Jul 2015 00:04:09 +0100
Message-ID: <20150716230409.GG1602@sirena.org.uk>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
 <20150701173802.GW11162@sirena.org.uk>
 <CAAObsKDsEuDS46rW9CMuviDEDV-OVXe5q-kiWmw0D_n2D3Tf5A@mail.gmail.com>
 <20150713154254.GH11162@sirena.org.uk>
 <CAAObsKAVY7-QpcRyT4juc2RyB+vqibvzKO7wFCT2VsL9R8bzPw@mail.gmail.com>
 <20150714110713.GT11162@sirena.org.uk>
 <CAAObsKAHviKKTrEBhuge-KQ115p-kOf69miNnmpR+7knOeg+qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKAHviKKTrEBhuge-KQ115p-kOf69miNnmpR+7knOeg+qg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-pwm@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 02:47:04PM +0200, Tomeu Vizoso wrote:
> On 14 July 2015 at 13:07, Mark Brown <broonie@kernel.org> wrote:

> > I'm not sure how I can be clearer here...  you're replacing something
> > that is currently pure data with open coding in each device.  That seems
> > like a step back in terms of ease of use.

> I could understand that if snd_soc_dai_link had a field with the
> property name, and the core called of_parse_phandle on it, but
> currently what I'm duplicating is:

>     tegra_max98090_dai.cpu_of_node = of_parse_phandle(np,
>             "nvidia,i2s-controller", 0);

> with:

>     add_dependency(fwnode, "nvidia,i2s-controller", deps);

> Admittedly, we could add a cpu_fw_property field to snd_soc_dai_link
> and have the core call of_parse_phandle itself.

Yes, we could - that's really what should be happening here.  The other
bit of this is that we're doing it twice which isn't success.

> But even then, the core doesn't know about a device's snd_soc_dai_link
> until probe() is called and then it's too late for the purposes of
> this series.

That's not a good reason to encourage bad patterns in drivers.  At the
very least the drivers should be able to pass the same struct into both
places, having to open code the same thing in two places is going to be
error prone.

> That's why I mentioned devm_probe, as it would add a common way to
> specify the data needed to acquire resources in each driver, which
> could be made available before probe() is called.

That does avoid the duplication.  However there are issues with the
interface for enumerable buses, it doesn't solve the problem where
embedded systems need you to power up the device manually prior to the
device actually enumerating.  If we're doing early resource acquisition
we probably want to solve that too.

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqDhpAAoJECTWi3JdVIfQ0EcH/1fH3N1Z4hr24sux74G4zKsC
226sv+YaCN1XJp+07CR6SX4FE6HgYtkP2FQ+DX469pB4ITIg15cQW4XAZBQOUG3Q
ZH5tzEU5b+pbcBsGGKII6CBwRRrWDwU0lDzNcSxdIhCbwIN0z1BIEQVlrnpnzFz9
IBsrOFjlxCKDfxHat20DG1A1jysmzL/qEIpmmuNFU8uDT9OTV0Qx0XTDjp4XKkz4
ZHv23T/xwtgo12y+fDfv+6fn9vbClThG8b+SZP7By/0qJ1JYGUEe6wG5WtBNYEo0
4FbOWTGDwVnKLbo1ksYK9DVkcPiJwDbTcCoxHHRdF53Ixz1xrjRCaRKkliC+AcM=
=j1su
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
