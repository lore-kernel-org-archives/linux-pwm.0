From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 05/11] drm: add Atmel HLCDC Display Controller support
Date: Tue, 23 Sep 2014 08:32:33 +0200
Message-ID: <20140923063232.GG30514@ulmo>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
 <1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140922211811.11279ff0@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0456871902=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140922211811.11279ff0@bbrezillon>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Andrew Victor <linux@maxim.org.za>
List-Id: linux-pwm@vger.kernel.org


--===============0456871902==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2014 at 09:18:11PM +0200, Boris BREZILLON wrote:
> On Mon,  8 Sep 2014 10:43:36 +0200 Boris BREZILLON <boris.brezillon@free-=
electrons.com> wrote:
[...]
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/Kconfig b/drivers/gpu/drm/atme=
l-hlcdc/Kconfig
> > new file mode 100644
> > index 0000000..6d0d785
> > --- /dev/null
> > +++ b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> > @@ -0,0 +1,13 @@
> > +config DRM_ATMEL_HLCDC
> > +	tristate "DRM Support for ATMEL HLCDC Display Controller"
> > +	depends on DRM && OF && MFD_ATMEL_HLCDC && COMMON_CLK
>=20
> I forgot to remove MFD_ATMEL_HLCDC dependency which is now selected...
>=20
>=20
> > +	select DRM_GEM_CMA_HELPER
> > +	select DRM_KMS_HELPER
> > +	select DRM_KMS_FB_HELPER
> > +	select DRM_KMS_CMA_HELPER
> > +	select DRM_PANEL
> > +	select MFD_ATMEL_HLCDC
>=20
> here.

Maybe this was discussed earlier, but can you remind me why this was
done? The changelog says it was to "simplify", but there's been some
recent discussion that select should never be used for symbols that
are user-visible because that can lead to issues.

What were the problems having this as "depends on"?

Thierry

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUIRQAAAoJEN0jrNd/PrOhft8QAL+ZOYjJyOpgiicjU90X4lOr
mIGldZckMCQX2bIw8vQHMvgCPImCamKVu2PZDEy+ncpfg2rEpAqiAX8oanizHVj9
QaUxulaxYeGmE96W5LZAaadZMLqM7GcaN7CldXdzIIsxRnVe03wZi7u+h99dz4JI
EBRPnZ5KeyAwL4DfUyVAvPbmyV72GJu34SLYzHPAIHT847q5WjxckrCD5PxBlxuq
8o8Zi/G8LdeenklJndc+/Myf5MTOvy0mxX0+5iXMsxSKMLNMPwgd2lKCUWh4id+x
kw5by4SR7yQiNX4nwe6oRFpzYO0jUoU62rggb2vrRwB29h0W3obM34MwMMfSj2uF
JXTN7EjlU0ChdiAvqlUk4Fl0dBgJjKl8JrLV+PLrKinTjU6RRUXh9YN/OrKJz8rP
VPfhY1R9EArPOje//V9kmWh0mtcyY+kjLnZAwqfb1pd+0mFkPeaXOuYWlsYuy5rS
mtX8E2rtoFQsJUTXlTS9nADig5L+NtvMS4tIiBFui7586rRqgUchjER/jTMWDJDy
hyKxwcHRCMNq+YEIhzXBnf1HfiHqlfNwRvPr+HbYlvwzNSfAb3QOYrP2h4CHJy22
Bx2nv1QcA7vqfVjI1SARkMtTL8KeaoOfnn8mQyWsJHY4bAKm7ZpqcDEm8T8M+CDC
2SWwtqYnxYEhQA8FAT/v
=OQV9
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--

--===============0456871902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0456871902==--
