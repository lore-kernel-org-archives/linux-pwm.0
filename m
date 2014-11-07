From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] backlight: pwm: clean up pwm requested using legacy
 API
Date: Fri, 7 Nov 2014 11:50:09 +0000
Message-ID: <20141107115009.GA3745@x1>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413035186-11771-3-git-send-email-vladimir_zapolskiy@mentor.com>
 <20141011142156.GC11456@kroah.com>
 <545BF1D1.30304@mentor.com>
 <20141106225420.GA2770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38699 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbaKGLuQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Nov 2014 06:50:16 -0500
Received: by mail-ig0-f172.google.com with SMTP id a13so12561116igq.17
        for <linux-pwm@vger.kernel.org>; Fri, 07 Nov 2014 03:50:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141106225420.GA2770@kroah.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

On Thu, 06 Nov 2014, Greg KH wrote:

> On Fri, Nov 07, 2014 at 12:10:25AM +0200, Vladimir Zapolskiy wrote:
> > Hello Greg, Thierry,
> >=20
> > On 11.10.2014 17:21, Greg KH wrote:
> > > On Sat, Oct 11, 2014 at 04:46:26PM +0300, Vladimir Zapolskiy wrot=
e:
> > >> If PWM device is requested by means of legacy API pwm_request(),=
 its
> > >> resources are not freed on module unbind, which may cause an oop=
s on
> > >> access, e.g. by reading /sys/kernel/debug/pwm.
> > >>
> > >> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> > >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com=
>
> > >> ---
> > >>  drivers/video/backlight/pwm_bl.c |    4 ++++
> > >>  1 file changed, 4 insertions(+)
> > >=20
> > > <formletter>
> > >=20
> > > This is not the correct way to submit patches for inclusion in th=
e
> > > stable kernel tree.  Please read Documentation/stable_kernel_rule=
s.txt
> > > for how to do this properly.
> > >=20
> > > </formletter>
> > > --
> >=20
> > could you please review the change? I believe it would be nice to h=
ave
> > oops fix in v3.18.
>=20
> drivers/video/ is not under my control, so there's nothing I can do
> here, sorry...

I can apply this with Thierry's Ack.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
