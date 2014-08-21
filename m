From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 00/11] drm: add support for Atmel HLCDC Display
 Controller
Date: Thu, 21 Aug 2014 11:04:07 +0200
Message-ID: <20140821090406.GA13733@ulmo>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140821081619.GZ2452@ldesroches-Latitude-E6320>
 <20140821103706.2349915d@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0113003876=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140821103706.2349915d@bbrezillon>
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


--===============0113003876==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2014 at 10:37:06AM +0200, Boris BREZILLON wrote:
> Hi Ludovic,
>=20
> On Thu, 21 Aug 2014 10:16:19 +0200
> Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
>=20
> > Hi Boris,
> >=20
> > You can add
> >=20
> > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>=20
> Thanks for testing this driver.
>=20
> >=20
> > Only one issue but not related to your patches, you can't display
> > quickly the bootup logo since the panel detection takes too much
> > time.
>=20
> Yes, actually this is related to the device probe order: the
> hlcdc-display-controller device is probed before the simple-panel, thus
> nothing is detected on the RGB connector (I use of_drm_find_panel to
> check for panel availability) when the display controller is
> instantiated. I rely on the default polling infrastructure provided by
> the DRM/KMS framework which polls for a new connector every 10s, and
> this is far more than you kernel boot time.
>=20
> Do anyone see a solution to reduce this delay (without changing the
> polling interval). I thought we could add a notifier infrastructure to
> the DRM panel framework, but I'm not sure this is how you want things
> done...

Other drivers return -EPROBE_DEFER when a panel hasn't been registered
yet. This will automatically take care of ordering things in a way that
DRM/KMS will only be initialized after the panel has been probed. That
will still cause some delay before everything gets set up, but hopefully
less than what you're seeing now. There's also another thread where this
is being discussed because deferred probing is causing "unacceptable"
delays as well.

Thierry

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9bYGAAoJEN0jrNd/PrOhiR0QAKPqY/pw7SOzbqhNaRLUXpyC
v45fgFc1yf/hBavH74nxqXDiYMXU2qHCp69zimUGfOpJn7JbwlvqT2LaeOd2yV5X
0PNVMpVaTqylfH9vfajwRE3NIWf/4qIHcGLyREKo4X/ancs8x4uOcNpH2/+J5YP0
+I7/sncqt/W1LimMBtjtLoSBB70iEMS/BAOpEauRwzwfHyyRj+BJ/pP6HCLNurOU
hL38P6ah3MJssunOoRJ0jwJGdJIHkratB27jgcV5HolnZyPHe5eUsS1vxTuPlrd4
oVrLbjYbWk2HOvhTsf/YC8FrfQ6wKmhxSDg6frUsZIpdU531/mujmjVLabQn1RMd
1hybaoI+sNhAqXd2e33V/ip/Pcp5/MOe6+PNPmVBuaxC9z9xbL4Z2ijVSmL1A7Hq
a/MS1fyhAA7Td9gPS00L5jRm9cqpSumyK8B3E53pRBWnczVe4YZ+puD5rxVpHDoq
b6bKvzpi6I2cQALYiHYWK2zRRs9p9CCvIKXUMdvvebYarbS98mSqw3FsWWq1F2ch
A4kV+I2WL5xwzEPr/bCbnEqHdPrWS67qVf3ft23yNdJNxDghd6oNgQzOvqPxb/wY
ZwcjSXDIycle6a/kIFBiddt/ka1QB8shCt7YSnLT7D2jPAqil7vFedccxywZeCQz
0GQbn5GBwABzigZ4bjVF
=r62m
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

--===============0113003876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0113003876==--
