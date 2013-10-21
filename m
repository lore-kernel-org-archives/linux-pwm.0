Return-Path: <ricardo.ribalda@gmail.com>
MIME-Version: 1.0
In-Reply-To: <526577FA.7070602@xs4all.nl>
References: <201309101134.32883.hansverk@cisco.com>
	<3335821.8epFKWiJXY@avalon>
	<CAK5ve-JHEaNrNiYwdMdEiEsD0LnqHG-MEAQv4D-962fYK0=g4A@mail.gmail.com>
	<2523390.YEHU3IBNqR@avalon>
	<CAK5ve-+N=GyNk-ryR0LbiUcT0TErFTwK60-vHNEf7112dNyh_A@mail.gmail.com>
	<525DF0C7.9090407@ti.com>
	<CAK5ve-K481KMXZJW9Ah8N_NaOYNNgdxABvewqiTOhquUAzr-UA@mail.gmail.com>
	<525F2311.8000509@ti.com>
	<1381968755.1905.25.camel@palomino.walls.org>
	<CAK5ve-Jnbr2C-LPfS9KKNcv8KH-7gkZyp+tj4Qt9-pE=nch8gg@mail.gmail.com>
	<CAPybu_2KRF_VHkjCEV8d7YOaZo27QJ=TxGTsUOeWO5X_tp8Ozw@mail.gmail.com>
	<CAK5ve-+PiRDEriYrCpbWq5WTPTq=n-xYZM0D46mDRAZWZi2GWw@mail.gmail.com>
	<526577FA.7070602@xs4all.nl>
Date: Mon, 21 Oct 2013 21:29:54 +0200
Message-ID: <CAPybu_1NZ-CfNkMt_stev5L9oL1MqSAhV03jQW7QoF=q4c2JzQ@mail.gmail.com>
Subject: Re: [media-workshop] V2: Agenda for the Edinburgh mini-summit
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Content-Type: multipart/alternative; boundary=e89a8fb1fa74fdaa0704e9454e91
List-ID: <linux-pwm.vger.kernel.org>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-pwm@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Paul Walmsley <paul@pwsan.com>, Andy Walls <awalls@md.metrocast.net>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Oliver Schinagl <oliver+list@schinagl.nl>, Hans Verkuil <hansverk@cisco.com>, linux-media <linux-media@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>, media-workshop@linuxtv.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bryan Wu <cooloney@gmail.com>, Bryan Wu <bryan.wu@canonical.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Thierry Reding <thierry.reding@gmail.com>

--e89a8fb1fa74fdaa0704e9454e91
Content-Type: text/plain; charset=ISO-8859-1

I thought that i was second... btw could i borrow somebodys notebook for
presenting the slides?

Thanks
On 21 Oct 2013 19:53, "Hans Verkuil" <hverkuil@xs4all.nl> wrote:

> On 10/21/2013 06:40 PM, Bryan Wu wrote:
> > On Sat, Oct 19, 2013 at 1:25 PM, Ricardo Ribalda Delgado
> > <ricardo.ribalda@gmail.com> wrote:
> >> Please find the multi selection api proposal attached.
> >>
> >> See you in Edinburgh.
> >>
> >>
> >> Thanks
> >>
> >> On Sat, Oct 19, 2013 at 2:17 AM, Bryan Wu <cooloney@gmail.com> wrote:
> >>> On Wed, Oct 16, 2013 at 5:12 PM, Andy Walls <awalls@md.metrocast.net>
> wrote:
> >>>> On Thu, 2013-10-17 at 08:36 +0900, Milo Kim wrote:
> >>>>
> >>>>>> That's current solution, we plan to unify this two API since those
> >>>>>> chip are basically LED.
> >>>>>>
> >>>>>>> On the other hands, LM3642 has an indicator mode with flash/torch.
> >>>>>>> Then, it will consist of 3 parts - MFD core, LED(indicator) and
> >>>>>>> V4L2(flash/torch).
> >>>>>>>
> >>>>>>
> >>>>>> So if one LED device driver can support that, we don't need these 3
> parts.
> >>>>>
> >>>>> Let me clarify our discussion briefly.
> >>>>>
> >>>>> For the flash and torch, there are scattered user-space APIs.
> >>>>> We need to unify them.
> >>>>
> >>>> Sorry for the late input.
> >>>>
> >>>> There are also subject matter illuminators (is that the same as
> torch?).
> >>>> They may be LED or halogen incadescent bulbs that are integral to a
> >>>> device such as the QX5 microscope:
> >>>>
> >>>>
> http://git.linuxtv.org/media_tree.git/blob/HEAD:/drivers/media/usb/cpia2/cpia2_v4l.c#l1152
> >>>>
> >>>> The V4L2 user controls ioctl()'s are used to control those two lamps
> >>>> currently.  Their activation seemed like a switch the user would want
> to
> >>>> turn easily, via a GUI that contained other V4L2 device controls.
> >>>>
> >>>> Do these fit in anywhere into the unification?  Not that I'm
> advocating
> >>>> that. I just thought cases like this shouldn't be overlooked in
> deciding
> >>>> what to do.
> >>>>
> >>>> Regards,
> >>>> Andy
> >>>>
> >>>>> We are considering supporting V4L2 structures in the LED camera
> trigger.
> >>>>> Then, camera application controls the flash/torch via not the LED
> sysfs
> >>>>> but the V4L2 ioctl interface.
> >>>>> So, changing point is the ledtrig-camera.c. No chip driver changes
> at all.
> >>>>>
> >>>>> Is it correct?
> >>>>>
> >>>>> Best regards,
> >>>>> Milo
> >>>>
> >>>>
> >>>
> >>> Please find my proposal attached and probably my colleague Paul
> >>> Walmsley will show up for this media mini summit if he is available.
> >>>
> >>> Thanks,
> >>> -Bryan
> >>
> >>
> >
> > Is the time and location of media mini-summit fixed? My colleague
> > might show up if it's not conflicted with ARM mini-summit.
>
> It's in the Glamis room on Wednesday. We start at 9 am and the LED topic
> is currently scheduled as the second topic so I expect that it will be
> discussed between 9 and 10 am.
>
> Regards,
>
>         Hans
>

--e89a8fb1fa74fdaa0704e9454e91
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I thought that i was second... btw could i borrow somebodys =
notebook for presenting the slides?</p>
<p dir=3D"ltr">Thanks</p>
<div class=3D"gmail_quote">On 21 Oct 2013 19:53, &quot;Hans Verkuil&quot; &=
lt;<a href=3D"mailto:hverkuil@xs4all.nl">hverkuil@xs4all.nl</a>&gt; wrote:<=
br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On 10/21/2013 06:40 PM, Bryan Wu wrote:<br>
&gt; On Sat, Oct 19, 2013 at 1:25 PM, Ricardo Ribalda Delgado<br>
&gt; &lt;<a href=3D"mailto:ricardo.ribalda@gmail.com">ricardo.ribalda@gmail=
.com</a>&gt; wrote:<br>
&gt;&gt; Please find the multi selection api proposal attached.<br>
&gt;&gt;<br>
&gt;&gt; See you in Edinburgh.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks<br>
&gt;&gt;<br>
&gt;&gt; On Sat, Oct 19, 2013 at 2:17 AM, Bryan Wu &lt;<a href=3D"mailto:co=
oloney@gmail.com">cooloney@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt; On Wed, Oct 16, 2013 at 5:12 PM, Andy Walls &lt;<a href=3D"mai=
lto:awalls@md.metrocast.net">awalls@md.metrocast.net</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; On Thu, <a href=3D"tel:2013-10-17" value=3D"+4520131017">2=
013-10-17</a> at 08:36 +0900, Milo Kim wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; That&#39;s current solution, we plan to unify this=
 two API since those<br>
&gt;&gt;&gt;&gt;&gt;&gt; chip are basically LED.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On the other hands, LM3642 has an indicator mo=
de with flash/torch.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Then, it will consist of 3 parts - MFD core, L=
ED(indicator) and<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; V4L2(flash/torch).<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; So if one LED device driver can support that, we d=
on&#39;t need these 3 parts.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Let me clarify our discussion briefly.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; For the flash and torch, there are scattered user-spac=
e APIs.<br>
&gt;&gt;&gt;&gt;&gt; We need to unify them.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Sorry for the late input.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; There are also subject matter illuminators (is that the sa=
me as torch?).<br>
&gt;&gt;&gt;&gt; They may be LED or halogen incadescent bulbs that are inte=
gral to a<br>
&gt;&gt;&gt;&gt; device such as the QX5 microscope:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; <a href=3D"http://git.linuxtv.org/media_tree.git/blob/HEAD=
:/drivers/media/usb/cpia2/cpia2_v4l.c#l1152" target=3D"_blank">http://git.l=
inuxtv.org/media_tree.git/blob/HEAD:/drivers/media/usb/cpia2/cpia2_v4l.c#l1=
152</a><br>

&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The V4L2 user controls ioctl()&#39;s are used to control t=
hose two lamps<br>
&gt;&gt;&gt;&gt; currently. =A0Their activation seemed like a switch the us=
er would want to<br>
&gt;&gt;&gt;&gt; turn easily, via a GUI that contained other V4L2 device co=
ntrols.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Do these fit in anywhere into the unification? =A0Not that=
 I&#39;m advocating<br>
&gt;&gt;&gt;&gt; that. I just thought cases like this shouldn&#39;t be over=
looked in deciding<br>
&gt;&gt;&gt;&gt; what to do.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt; Andy<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; We are considering supporting V4L2 structures in the L=
ED camera trigger.<br>
&gt;&gt;&gt;&gt;&gt; Then, camera application controls the flash/torch via =
not the LED sysfs<br>
&gt;&gt;&gt;&gt;&gt; but the V4L2 ioctl interface.<br>
&gt;&gt;&gt;&gt;&gt; So, changing point is the ledtrig-camera.c. No chip dr=
iver changes at all.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Is it correct?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Best regards,<br>
&gt;&gt;&gt;&gt;&gt; Milo<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Please find my proposal attached and probably my colleague Pau=
l<br>
&gt;&gt;&gt; Walmsley will show up for this media mini summit if he is avai=
lable.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; -Bryan<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; Is the time and location of media mini-summit fixed? My colleague<br>
&gt; might show up if it&#39;s not conflicted with ARM mini-summit.<br>
<br>
It&#39;s in the Glamis room on Wednesday. We start at 9 am and the LED topi=
c<br>
is currently scheduled as the second topic so I expect that it will be<br>
discussed between 9 and 10 am.<br>
<br>
Regards,<br>
<br>
=A0 =A0 =A0 =A0 Hans<br>
</blockquote></div>

--e89a8fb1fa74fdaa0704e9454e91--
