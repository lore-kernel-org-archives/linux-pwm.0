Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43927 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEaJ3H (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 05:29:07 -0400
MIME-Version: 1.0
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVjOuvUyX3QJP-DOmYt3wzt3NOioDfm_CQhyZvOnGgy6Q@mail.gmail.com> <OSAPR01MB3089658CD2E8DF789BA7737FD8190@OSAPR01MB3089.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB3089658CD2E8DF789BA7737FD8190@OSAPR01MB3089.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 May 2019 11:28:52 +0200
Message-ID: <CAMuHMdUkYChEX+uaxqAhHRTDKPST9HZNqOKGTf2kxM0F+_nsxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 1/4] pwm: Add power management descriptions
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Shimoda-san,

On Fri, May 31, 2019 at 11:22 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > On Thu, May 30, 2019 at 12:21 PM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > This patch adds power management descriptions that consumers should
> > > implement it.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/Documentation/pwm.txt
> > > +++ b/Documentation/pwm.txt
> >
> > > @@ -141,6 +145,9 @@ The implementation of ->get_state() (a method used to retrieve initial PWM
> > >  state) is also encouraged for the same reason: letting the PWM user know
> > >  about the current PWM state would allow him to avoid glitches.
> > >
> > > +Drivers should not implement any power management. In other words,
> > > +consumers should implement it as described as the "Using PWMs" section.
> >
> > s/as/in/
>
> So, "... in described as ..." ?
>
> I'm not a native speaker, so that any cases below seem not so different to me :)
>
> 1. "... as described as ..."
> 2. "... in described as ..."
> 3. "... as described in ..."
> 4. "... in described in ..."

Sorry for being unclear: "... as described in ..."

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
