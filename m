From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/6] pwm: imx: Provide atomic operation for IMX PWM driver
Date: Tue, 25 Oct 2016 15:08:21 -0200
Message-ID: <CAOMZO5Bnfg43VY6tdsahCQ3PoVaL+wCzmPLCMTBK39FCHY9SpQ@mail.gmail.com>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <20161024173607.36bc2cb9@bbrezillon> <20161024232615.77d4ea28@jawa>
 <35a950b7ff431e0545bbb259ba69b483@agner.ch> <20161025090724.727c10bc@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161025090724.727c10bc@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

Hi Lukasz,

On Tue, Oct 25, 2016 at 5:07 AM, Lukasz Majewski <l.majewski@majess.pl> wrote:

> With the newest mainline 4.9-rcX
> SHA:0c2b6dc4fd4fa13796b319aae969a009f03222c6
>
> the i.MX6q is not booting. Apparently I do need to wait for things to
> calm down.

Does this commit help with the boot issue you observed?
