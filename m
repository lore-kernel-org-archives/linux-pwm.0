From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
Date: Mon, 24 Sep 2018 16:23:18 +0200
Message-ID: <20180924142318.GG23547@ulmo>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo>
 <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: stefan.wahren@i2se.com, gohai@sukzessiv.net, hsweeten@visionengravers.com, gottfried.haider@gmail.com, loic.pallardy@st.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:59:03PM +0200, Fabrice Gasnier wrote:
> On 09/24/2018 01:53 PM, Thierry Reding wrote:
> > On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
> >> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it cau=
ses
> >> regression with multiple pwm chip. It creates a new entry in
> >> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export=
':
> >> - 1st time export will create an entry in /sys/class/pwm/pwmX
> >> - when another export happens on another pwmchip, it can't be created
> >> (e.g. -EEXIST)
> >>
> >> This also changes existing ABI (Documentation/ABI/testing/sysfs-class-=
pwm):
> >> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
> >>
> >> Example on stm32 (stm32429i-eval) platform:
> >> $ ls /sys/class/pwm
> >> pwmchip0 pwmchip4
> >>
> >> $ cd /sys/class/pwm/pwmchip0/
> >> $ echo 0 > export
> >> $ ls /sys/class/pwm
> >> pwm0 pwmchip0 pwmchip4
> >>
> >> $ cd /sys/class/pwm/pwmchip4/
> >> $ echo 0 > export
> >> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> >> ...Exception stack follows...
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >>  drivers/pwm/sysfs.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >=20
> > Can we come up with an alternative that allows us to have both? We want
> > uevent and proper sysfs creation, or is that not possible?
>=20
> Hi Thierry, all,
>=20
> With current approach:
> - "export->child.class =3D parent->class"
> - ABI (e.g. "pwm%d") device name isn't unique with multiple pwm chip.
> I think this is not possible.
>=20
> Trying to think of an alternative... I just did a quick test, by
> changing device name, to take pwmchip into account:
> +       export->child.class =3D parent->class;
>         export->child.release =3D pwm_export_release;
>         export->child.parent =3D parent;
>         export->child.devt =3D MKDEV(0, 0);
>         export->child.groups =3D pwm_groups;
> -       dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
> +       dev_set_name(&export->child, "pwmchip%d-pwm%u", chip->base,
> pwm->hwpwm);
>=20
> But this also impacts existing ABI :-(
> Would you have suggestions to send an uevent, without modifying ABI ?

I don't quite understand why, in the example you show in the commit
message, the pwmX nodes appear in the top-level /sys/class/pwm
directory. According to Documentation/ABI/testing/sysfs-class-pwm they
should appear as /sys/class/pwm/pwmchipN/pwmX. I can only imagine that
setting the class may have changed that. If so, perhaps we can
workaround that by creating a new class that is not parent->class?

Thierry

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluo81YACgkQ3SOs138+
s6GxAA//WkdXn0Zu2emfyYspUknO2Yb9looGZZElPqNLt0YPaWPcryc8JSxRE5p/
aE31wGjwOK6eHRWgqWI18XC0W/67yyzF9MgzzcM39JW+ApM1OfEOShItNj8Xs1aS
/9GgndxL2NpaSxkIiZJd/yhJOYMIQtyvpuy+0ealFLB+XNah2jW8r9I07xD+bWwL
UjLIA2cB/o8kdTuxF0aOW0nG4j/O74hI+ctyFqobPFEG7+ggtLgCqLhZvEydD5g1
tItLAcR73YQ9ZLWunePCdJIAiKY6eaITCaLyYR35pFHMSC5vHp9M1maqHQpsGtjA
602kPP3em0UOr+92421mIjYWwgR08d03TKtzOMn0g2lvKVmPIbxrv5Z6H9c+ueJl
q4QY14ogGdUTRA/ODiBET97P9OGfWsYB91qSwfDzool+7wgG5oxdNzXIjUFsW/89
X1ny7+ULzMe6ft3x7ePOnRW+15t7pYILWQRsgd/4IVJGfH1wfP/GrAWkJ1JZyybq
dDogVXTU4nhIhTc1T5m9WwCp41VkXoQVPUo8P7tpWExa0oq8mH8CPZSJZLGfE+Bc
DF6wIfUhjJuyf0xBezDTAEfmHwRwLHI5uGV2tJUbD13NrlK3TxBFlF6751M12btK
yZvYqbbiF+QPLF1pNMHD3r1m3Hm0wuE+DwnUA+PvqkofCnCueps=
=FmsP
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--
