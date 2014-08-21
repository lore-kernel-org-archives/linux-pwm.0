From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 00/11] drm: add support for Atmel HLCDC Display
 Controller
Date: Thu, 21 Aug 2014 11:52:03 +0200
Message-ID: <20140821095202.GA21848@ulmo>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140821081619.GZ2452@ldesroches-Latitude-E6320>
 <20140821103706.2349915d@bbrezillon> <20140821090406.GA13733@ulmo>
 <20140821114159.319e741b@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1649129203=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140821114159.319e741b@bbrezillon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============1649129203==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2014 at 11:41:59AM +0200, Boris BREZILLON wrote:
> On Thu, 21 Aug 2014 11:04:07 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Thu, Aug 21, 2014 at 10:37:06AM +0200, Boris BREZILLON wrote:
> > > Hi Ludovic,
> > >=20
> > > On Thu, 21 Aug 2014 10:16:19 +0200
> > > Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> > >=20
> > > > Hi Boris,
> > > >=20
> > > > You can add
> > > >=20
> > > > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > >=20
> > > Thanks for testing this driver.
> > >=20
> > > >=20
> > > > Only one issue but not related to your patches, you can't display
> > > > quickly the bootup logo since the panel detection takes too much
> > > > time.
> > >=20
> > > Yes, actually this is related to the device probe order: the
> > > hlcdc-display-controller device is probed before the simple-panel, th=
us
> > > nothing is detected on the RGB connector (I use of_drm_find_panel to
> > > check for panel availability) when the display controller is
> > > instantiated. I rely on the default polling infrastructure provided by
> > > the DRM/KMS framework which polls for a new connector every 10s, and
> > > this is far more than you kernel boot time.
> > >=20
> > > Do anyone see a solution to reduce this delay (without changing the
> > > polling interval). I thought we could add a notifier infrastructure to
> > > the DRM panel framework, but I'm not sure this is how you want things
> > > done...
> >=20
> > Other drivers return -EPROBE_DEFER when a panel hasn't been registered
> > yet. This will automatically take care of ordering things in a way that
> > DRM/KMS will only be initialized after the panel has been probed.
>=20
> Actually I'd like to avoid doing this with a deferred probe, because,
> AFAIU, the remote endpoint is not tightly linked with the display
> controller driver (I mean the display controller can still be
> initialized without having a display connected on it).
> Moreover the atmel dev kit I'm using has an HDMI bridge connected on
> the same RGB connector and I'd like to use it in a near future.
> Returning -EPROBE_DEFER in case of several devices connected on the
> same connector implies that I'll have to wait for all the remote
> end-points to be available before my display controller could be
> instantiated.
>=20
> While this could be acceptable when all drivers are statically linked
> in the kernel, it might be problematic when you're using modules,
> meaning that you won't be able to display anything on your LCD panel
> until your HDMI bridge module has been loaded.

No. HDMI should be using proper hotplugging anyway, hence it should be
always be loaded anyway. You're in for a world of pain if you think you
can run DRM with a driver that's composed of separate kernel modules.

Also if you don't want to use deferred probe, then you're in for the
full hotplugging panel dance and that implies that you need to fix a
bunch of things in DRM (one being the framebuffer console instantiation
that I referred to in the other thread). You also can't be using the
current device tree bindings because they all assume a dependency from
the display controller/output to the panel. For hotplugging you'd need
the dependency the other way around (the panel needs to refer to the
output by phandle).

> > That
> > will still cause some delay before everything gets set up, but hopefully
> > less than what you're seeing now. There's also another thread where this
> > is being discussed because deferred probing is causing "unacceptable"
> > delays as well.
>=20
> Could you point this thread out to me please ?

I Cc'ed you on it.

Thierry

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9cFCAAoJEN0jrNd/PrOhiFgQAL6GbxU2+Le7OUA03OKhMytV
laoZLOyi78I9uIJzr5KULoGBj3Rv5mKS/pmd96VFBG6nZVa5zEz2glikm5UgzGTV
MyrUKxWLOV5/JiEYRLZ+iExNgvNZ3Ms/X598rg+v0oyT+rulhtAqwqAAF787G3tC
XC71KXXaT9tlQ7OAvefW8ZkHtA4Z7DUZ2UnlHZ68I9U6INKewCbT4EFl8PP8tLra
sVtiHz61Z3X8yoZOTsR69tfUe+MolvGre1oZt+XEIjiXzDnxqkMO6eCw4JzpJY5/
Ojh4OdtzJu5/hz4WbaI7W5SMfRMk7nCfnkL9bNUEoSlpRO1qR2J/hSWB8qLrAqZn
GbInnxeeF0CbGfQf26f+9sF+wMoZx6VyX4+k5D89VLy1bPvGNhHcco3cAQApvpLx
c2rIdjHYTRdwvuNiwS6iFQGa27pw/0vjbIgEvi0msPO0gvAImBLVwfq44vgBN9Rl
P1H4OesAexmMS9z3YRcmgrpT6U7g69C3jwiXnSW/7m5drZ9SPfBPoIPN3PX9j8xl
22LuP6XboR6m3QRtwC1kvVJ/doN62nUwlbN7yzYonTz5dkgT9WSof2cdOBrv2dOE
QjSWEw8B4IVuDEuGlL+HVg1LOfHJuwxC975r1RTEwez2h41LSMfcFOAMnAX2yQt6
aoMc2vksH07+W1YQher9
=APGR
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--===============1649129203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1649129203==--
