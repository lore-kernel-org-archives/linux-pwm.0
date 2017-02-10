From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Fix compile error in pwm_get()
Date: Fri, 10 Feb 2017 15:23:12 +0100
Message-ID: <20170210142312.GA10204@ulmo.ba.sec>
References: <20170210114430.21512-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33776 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbdBJOa7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Feb 2017 09:30:59 -0500
Received: by mail-wr0-f194.google.com with SMTP id i10so15334424wrb.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Feb 2017 06:30:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170210114430.21512-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pwm@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 12:44:30PM +0100, Hans de Goede wrote:
> commit bf71f4e8fb95 ("pwm: Try to load modules during pwm_get()") had
> error checking added to the request_module call it adds, before merging
> it. But the "err" variable the error checking uses was never declared,
> this commit fixes this.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Feel free to squash this into the original commit
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You had me really confused there for a little bit. Turns out I had two
versions of that patch in my tree, one with the missing variable
declaration and another where I had already added it after build tests
had failed. The old patch stuck around because it was part of a branch
that I had created in case anyone wanted to pull this into the ACPI
tree to resolve dependencies and I had forgotten to rebase that branch
onto the fixed patch.

I've pushed a new set of branches, so this confusion should be gone by
tomorrow. It's a little odd that you even saw this failing to build,
since none of the farms seemed to have noticed, and the file in
linux-next is actually the correct one.

Thierry

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlidzMwACgkQ3SOs138+
s6GQnA/+O15MIV5oYUrLiW7t4xqDuCxgC/LTZ7KrHdYvVrAmu+EPaqGD9Jg5Onb2
VZtRrsbjcecPNQHmfKfz3SNMz5WhHAaR9YBfH/bNNe4dGPpBe1U+0Fc+VCZ8b3X5
D8E/RDlvudaY3K7TdCnz3ASHGwKPukwRalJwlPVzRCdo5mtIHK8+1jUjQd48zmz7
VDUHnr8BmyOpDcnnjRWXMi1zOJfOcwXoFi6RVwaY2mHFPr8nUDWDG92J5NemEbVk
DBmw93sra87GvUo+q9zm/7Ww9th/C+bMVU5YLL0eBnx5IJwc4rNTHYDuJkM1DIgZ
UnjkYAOOiuC/EkbSeR/sXGKHG3Vx1VQArV7gjGiNXDop6Y393RyXeT8T9Ti1k1vY
gn8mvfuvBt5pxYmxSTeJFXszhTH7jDS6gk2K/8aM2KgmhsgIC8UNDpBxLglOmowQ
qxpape6xNA++6Cy6Clj7aQVvfbpCyEUpKIngIMtbBlXIQnL4DsIZAByTYwHJjEcm
eEYsN6BGlg8e1+vH52TWifIS1WalxWuaGhEcURpPvNyg/gaz0Z5cQPFVG6qyHQOv
NcUkONOXRBwktHeM0pWA1mc/E0dozASJhSAoPVBbPDi/91kSoCfiBPlxsNuTIss2
veaKmywe2rbfhqRs9lrGUM5VR9Cq11apvUsoPTRQCGHblmhr6Zk=
=zYKR
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
