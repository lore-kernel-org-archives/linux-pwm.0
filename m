From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
Date: Tue, 25 Sep 2018 17:20:22 +0200
Message-ID: <20180925152022.GB27695@ulmo>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo>
 <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
 <20180924142318.GG23547@ulmo>
 <c4866533-1c7e-2675-5d80-3b824e32ae9b@st.com>
 <4278fef9-ec60-239a-dd0a-29a89d742fa4@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4278fef9-ec60-239a-dd0a-29a89d742fa4@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>, Gottfried Haider <gottfried.haider@gmail.com>
Cc: stefan.wahren@i2se.com, gohai@sukzessiv.net, hsweeten@visionengravers.com, loic.pallardy@st.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, michal.vokac@ysoft.com
List-Id: linux-pwm@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2018 at 03:59:26PM +0200, Fabrice Gasnier wrote:
> On 09/24/2018 05:50 PM, Fabrice Gasnier wrote:
> > On 09/24/2018 04:23 PM, Thierry Reding wrote:
> >> On Mon, Sep 24, 2018 at 03:59:03PM +0200, Fabrice Gasnier wrote:
> >>> On 09/24/2018 01:53 PM, Thierry Reding wrote:
> >>>> On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
> >>>>> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it =
causes
> >>>>> regression with multiple pwm chip. It creates a new entry in
> >>>>> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > exp=
ort':
> >>>>> - 1st time export will create an entry in /sys/class/pwm/pwmX
> >>>>> - when another export happens on another pwmchip, it can't be creat=
ed
> >>>>> (e.g. -EEXIST)
> >>>>>
> >>>>> This also changes existing ABI (Documentation/ABI/testing/sysfs-cla=
ss-pwm):
> >>>>> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
> >>>>>
> >>>>> Example on stm32 (stm32429i-eval) platform:
> >>>>> $ ls /sys/class/pwm
> >>>>> pwmchip0 pwmchip4
> >>>>>
> >>>>> $ cd /sys/class/pwm/pwmchip0/
> >>>>> $ echo 0 > export
> >>>>> $ ls /sys/class/pwm
> >>>>> pwm0 pwmchip0 pwmchip4
> >>>>>
> >>>>> $ cd /sys/class/pwm/pwmchip4/
> >>>>> $ echo 0 > export
> >>>>> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> >>>>> ...Exception stack follows...
> >>>>>
> >>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >>>>> ---
> >>>>>  drivers/pwm/sysfs.c | 1 -
> >>>>>  1 file changed, 1 deletion(-)
> >>>>
> >>>> Can we come up with an alternative that allows us to have both? We w=
ant
> >>>> uevent and proper sysfs creation, or is that not possible?
> >>>
> >>> Hi Thierry, all,
> >>>
> >>> With current approach:
> >>> - "export->child.class =3D parent->class"
> >>> - ABI (e.g. "pwm%d") device name isn't unique with multiple pwm chip.
> >>> I think this is not possible.
> >>>
> >>> Trying to think of an alternative... I just did a quick test, by
> >>> changing device name, to take pwmchip into account:
> >>> +       export->child.class =3D parent->class;
> >>>         export->child.release =3D pwm_export_release;
> >>>         export->child.parent =3D parent;
> >>>         export->child.devt =3D MKDEV(0, 0);
> >>>         export->child.groups =3D pwm_groups;
> >>> -       dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
> >>> +       dev_set_name(&export->child, "pwmchip%d-pwm%u", chip->base,
> >>> pwm->hwpwm);
> >>>
> >>> But this also impacts existing ABI :-(
> >>> Would you have suggestions to send an uevent, without modifying ABI ?
> >>
> >> I don't quite understand why, in the example you show in the commit
> >> message, the pwmX nodes appear in the top-level /sys/class/pwm
> >> directory. According to Documentation/ABI/testing/sysfs-class-pwm they
> >> should appear as /sys/class/pwm/pwmchipN/pwmX. I can only imagine that
> >> setting the class may have changed that.
> >=20
> > Yes, adding the class makes the link to be created under /sys/class/pwm:
> > device_register() -> device_add() -> device_add_class_symlinks()
> > In device_add_class_symlinks():
> > ...
> > 	if (!dev->class)
> > 		return 0;
> > ...
> > 	/* link in the class directory pointing to the device */
> > 	error =3D sysfs_create_link(&dev->class->p->subsys.kobj,
> > 				  &dev->kobj, dev_name(dev));
> > ...
> >=20
> >> If so, perhaps we can
> >> workaround that by creating a new class that is not parent->class?
>=20
> Hi Thierry,
>=20
> Maybe there's a way around, keeping the revert patch, without impacting
> the ABI:
> - pwmX cannot be added to pwm/another class without issue as discussed
> (numbering isn't unique).
> - pwmchipN already belongs to pwm class.

Yeah, I think setting the exported PWM's class to that of the parent is
completely wrong. I just gave that a quick test and we get some strange
behaviour with that. For example we actually get two directories
created, one in /sys/class/pwm and another in the parent chip's
directory (e.g. /sys/class/pwmchip0).

One issue is of course that, as you reported, we get a duplicate file
because the numbering starts at 0 for each PWM chip. But what we also
get is a situation where each PWM channel is interpreted as a PWM chip
because it has the same class as the PWM chip.

So the /sys/class/pwm/pwm0 device gets the same attributes as its parent
chip, which means you get, among others, also the export attribute. What
happens then is really bad, because you can write to that file and the
kernel will oops. In my case it didn't actually panic, but it ended up
killing the shell and giving me a login prompt. The reason is of course
that the sysfs implementation assumes that anything that has the PWM
class is actually a PWM chip.

So I think the best course of action is to revert the offending commit
for now and get it reverted on all stable releases since it was applied
given how easy it now is to crash the kernel. Luckily sysfs requires
root privileges, so it's not a major security issue by default. However
since the purpose of the offending commit was to allow userspace to get
access to a PWM for non-root users, it means that random users can
potentially crash the kernel if userspace is configured to hand out
access randomly.

> I did some testing, trying to send uevent on the pwmX directly, without
> success: uevents are filtered as pwmX doesn't belong to a class.
>=20
> Still, it is possible to send uevent (KOBJ_CHANGE) on pwmchipN device,
> to notify of a change, e.g. pwmX channel being exported/unexported.
>=20
> I run following prototype (with revert patch).
>=20
> static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
>  {
> +       char *pwm_prop[2];
>         struct pwm_export *export;
>         int ret;
>  ...
>                 kfree(export);
>                 return ret;
>         }
> +       pwm_prop[0] =3D kasprintf(GFP_KERNEL, "EXPORT=3Dpwm%u", pwm->hwpw=
m);
> +       pwm_prop[1] =3D NULL;
> +       kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
> +       kfree(pwm_prop[0]);
>=20
>         return 0;
>  }
>=20
>  static int pwm_unexport_child(struct device *parent, struct pwm_device
> *pwm)
>  {
>         struct device *child;
> +       char *pwm_prop[2];
>=20
>         if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
>                 return -ENODEV;
> ...
>         if (!child)
>                 return -ENODEV;
>=20
> +       pwm_prop[0] =3D kasprintf(GFP_KERNEL, "UNEXPORT=3Dpwm%u", pwm->hw=
pwm);
> +       pwm_prop[1] =3D NULL;
> +       kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
> +       kfree(pwm_prop[0]);
> +
>         /* for device_find_child() */
>=20
> Then, I run a quick test:
>=20
> # udevadm monitor --environment &
> # echo 0 > /sys/class/pwm/pwmchip0/export
> KERNEL[197.321736] change   /devices/.../pwm/pwmchip0 (pwm)
> ACTION=3Dchange
> DEVPATH=3D/devices/.../pwm/pwmchip0
> EXPORT=3Dpwm0
> SEQNUM=3D2045
> SUBSYSTEM=3Dpwm
>=20
> # echo 0 > /sys/class/pwm/pwmchip4/export
> KERNEL[202.089676] change   /devices/.../pwm/pwmchip4 (pwm)
> ACTION=3Dchange
> DEVPATH=3D/devices/.../pwm/pwmchip4
> EXPORT=3Dpwm0
> SEQNUM=3D2046
> SUBSYSTEM=3Dpwm
>=20
>=20
> Also unexport will report change events to userland:
>=20
> # echo 0 > /sys/class/pwm/pwmchip0/unexport
> KERNEL[1691.112765] change   /devices/.../pwm/pwmchip0 (pwm)
> ACTION=3Dchange
> DEVPATH=3D/devices/.../pwm/pwmchip0
> SEQNUM=3D2047
> SUBSYSTEM=3Dpwm
> UNEXPORT=3Dpwm0
>=20
> Do you think this may be a way around?
> Please let me know if this may satisfy need for uevents.

This is certainly interesting. However, if I interpret the commit
message of the offending commit correctly, the reason why the class was
set is because they wanted uevents to be sent for the individual PWM
devices. And I think they want KOBJ_ADD events to be sent so that they
can set permissions using udev, for example.

I'm not sure if udev could be configured to do this based on the EXPORT
and UNEXPORT uevent variables.

Let's see if Gottfried can clarify that.

Thanks for investigating this,
Thierry

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqUjMACgkQ3SOs138+
s6FFKRAAtq8SSyQ1QRuMvib2irQUzA5GXkZRjLTJJRYknN3ujjP2IRb96oU9EGrW
ym4keeQD4LtzomQTLDymb4u/dCHe/6quU4Sk3RaxGyZWo936CR8kilYSy7Q+wgkF
V7Sy2IeLJCTpyYTJ2rY+uEe3qx6yzBpkFw6voxrBVwZfnXE3n5vSVQbK1FjluaQI
AV688nukibz6IQf9ZyIbVbHE/5G6qaPnTZXYKligeffphKHiM+xaRjp8yXCO/Yb3
KeXH8ztECA296FhXjsRMhQOLno7PNHsE3AszXWzBUnFcg7sd3uFJALjuFlVFARZH
BvguRl4dng4UjsI3o+ldZjFJM2OWxd3SVl+V1R5Flmjtct8uwx3YFquYRnBnfXUk
4C6NgztfISnWSqFXq1yT3nZfto3WmWzfj48OYBT9p94q/3FJZa7UZ7W7ZLfzL1Xe
M+hJ/J6rrWwwYTleqDrJFO/W2+uE6FTGCL378/vITBQyWFBF47bAefeqgQPGkZZy
MOpQTYjF86zXXeeqDqcEtnnjizIhC6cHtHL16uFKLsr6R8HAqjzwTzjTY30Z0Nas
HeyW3FL0PKRuZ36SB2VSGicBD3c/ga/fg92pKaJVn6D0n3vmgkJzuwT/2xtuuxpi
kDgZ7vME1kZCIuTWu48IpgiV5laEENUUBFT1GuRKmVa0cgwTwf4=
=iLwK
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
