Return-Path: <nvaccaro@google.com>
MIME-Version: 1.0
In-Reply-To: <20170623202313.GA122611@google.com>
References: <20170622175439.81256-1-nvaccaro@chromium.org> <20170623202313.GA122611@google.com>
From: Nick Vaccaro <nvaccaro@google.com>
Date: Fri, 23 Jun 2017 14:04:44 -0700
Message-ID: <CAME0mb0RJ81FBixF-u3Pq7+iJoLKLkqZJiFSdm25_rHCfw_Msw@mail.gmail.com>
Subject: Re: [PATCH] FIXUP: CHROMIUM: fix transposed param settings
Content-Type: multipart/alternative; boundary="001a114156526a97340552a6f3a7"
List-ID: <linux-pwm.vger.kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

--001a114156526a97340552a6f3a7
Content-Type: text/plain; charset="UTF-8"

Hi Brian,
Thanks for the info, I'm new to this process.

I was asked to create a FIXUP CL and send it upstream.  Not knowing format
of a "FIXUP" cl, I looked at other FIXUP cl's in the chromeos kernel and
followed suit.
I emailed it upstream with a "FIXUP: CHROMIUM:" prefix. Should I change the
checkin comment title line to "[PATCH] pwm: cros-ec: fix transposed param
settings" and resend the email?
Please advise, thanks.

On Fri, Jun 23, 2017 at 1:23 PM, Brian Norris <briannorris@chromium.org>
wrote:

> Hi Nick,
>
> When sending patches to kernel mailing lists, we don't use prefixes like
> "CHROMIUM" -- those only apply to Chrome OS kernel trees, to indicate
> patches that should be specific to the Chromium (OS) project and not
> necessarily upstream Linux.
>
> Here, you want to follow the patterns used by the subsystem. This is
> sort of covered in the Documentation/process/ directory:
>
> https://www.kernel.org/doc/html/latest/process/
> submitting-patches.html#the-canonical-patch-format
>
> Or you might look at 'git log drivers/pwm/ here.
>
> i.e., this might have a subject:
>
> [PATCH] pwm: cros-ec: fix transposed param settings
>
> On Thu, Jun 22, 2017 at 10:54:39AM -0700, Nick Vaccaro wrote:
> > The __cros_ec_pwm_get_duty() routine was transposing the insize and
> > outsize fields when calling cros_ec_cmd_xfer_status().
> >
> > The original code worked without error due to size of the two particular
> > parameter blocks passed to cros_ec_cmd_xfer_status(), so this change is
> > not fixing an actual runtime problem, just correcting the calling usage.
> >
> > Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> > ---
>
> Patch looks good:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
>
> >  drivers/pwm/pwm-cros-ec.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> > index 2e4ab20cfb83..de5b7c9860b6 100644
> > --- a/drivers/pwm/pwm-cros-ec.c
> > +++ b/drivers/pwm/pwm-cros-ec.c
> > @@ -75,8 +75,8 @@ static int __cros_ec_pwm_get_duty(struct
> cros_ec_device *ec, u8 index,
> >
> >       msg->version = 0;
> >       msg->command = EC_CMD_PWM_GET_DUTY;
> > -     msg->insize = sizeof(*params);
> > -     msg->outsize = sizeof(*resp);
> > +     msg->insize = sizeof(*resp);
> > +     msg->outsize = sizeof(*params);
> >
> >       params->pwm_type = EC_PWM_TYPE_GENERIC;
> >       params->index = index;
>

--001a114156526a97340552a6f3a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Brian,<br>Thanks for the info, I&#39;m new to this proc=
ess.<br><br>I was asked to create a FIXUP CL and send it upstream.=C2=A0 No=
t knowing format of a &quot;FIXUP&quot; cl, I looked at other FIXUP cl&#39;=
s in the chromeos kernel and followed suit. =C2=A0<br>I emailed it upstream=
 with a &quot;FIXUP: CHROMIUM:&quot; prefix. Should I change the checkin co=
mment title line to &quot;[PATCH] pwm: cros-ec: fix transposed param settin=
gs&quot; and resend the email?<br>Please advise, thanks.</div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jun 23, 2017 at 1:23 P=
M, Brian Norris <span dir=3D"ltr">&lt;<a href=3D"mailto:briannorris@chromiu=
m.org" target=3D"_blank">briannorris@chromium.org</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Nick,<br>
<br>
When sending patches to kernel mailing lists, we don&#39;t use prefixes lik=
e<br>
&quot;CHROMIUM&quot; -- those only apply to Chrome OS kernel trees, to indi=
cate<br>
patches that should be specific to the Chromium (OS) project and not<br>
necessarily upstream Linux.<br>
<br>
Here, you want to follow the patterns used by the subsystem. This is<br>
sort of covered in the Documentation/process/ directory:<br>
<br>
<a href=3D"https://www.kernel.org/doc/html/latest/process/submitting-patche=
s.html#the-canonical-patch-format" rel=3D"noreferrer" target=3D"_blank">htt=
ps://www.kernel.org/doc/<wbr>html/latest/process/<wbr>submitting-patches.ht=
ml#the-<wbr>canonical-patch-format</a><br>
<br>
Or you might look at &#39;git log drivers/pwm/ here.<br>
<br>
i.e., this might have a subject:<br>
<br>
[PATCH] pwm: cros-ec: fix transposed param settings<br>
<span class=3D""><br>
On Thu, Jun 22, 2017 at 10:54:39AM -0700, Nick Vaccaro wrote:<br>
&gt; The __cros_ec_pwm_get_duty() routine was transposing the insize and<br=
>
&gt; outsize fields when calling cros_ec_cmd_xfer_status().<br>
&gt;<br>
&gt; The original code worked without error due to size of the two particul=
ar<br>
&gt; parameter blocks passed to cros_ec_cmd_xfer_status(), so this change i=
s<br>
&gt; not fixing an actual runtime problem, just correcting the calling usag=
e.<br>
&gt;<br>
&gt; Signed-off-by: Nick Vaccaro &lt;<a href=3D"mailto:nvaccaro@chromium.or=
g">nvaccaro@chromium.org</a>&gt;<br>
&gt; ---<br>
<br>
</span>Patch looks good:<br>
<br>
Reviewed-by: Brian Norris &lt;<a href=3D"mailto:briannorris@chromium.org">b=
riannorris@chromium.org</a>&gt;<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;=C2=A0 drivers/pwm/pwm-cros-ec.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c<br>
&gt; index 2e4ab20cfb83..de5b7c9860b6 100644<br>
&gt; --- a/drivers/pwm/pwm-cros-ec.c<br>
&gt; +++ b/drivers/pwm/pwm-cros-ec.c<br>
&gt; @@ -75,8 +75,8 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_dev=
ice *ec, u8 index,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0msg-&gt;version =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0msg-&gt;command =3D EC_CMD_PWM_GET_DUTY;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0msg-&gt;insize =3D sizeof(*params);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0msg-&gt;outsize =3D sizeof(*resp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msg-&gt;insize =3D sizeof(*resp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msg-&gt;outsize =3D sizeof(*params);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;pwm_type =3D EC_PWM_TYPE_GENERIC;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0params-&gt;index =3D index;<br>
</div></div></blockquote></div><br></div>

--001a114156526a97340552a6f3a7--
