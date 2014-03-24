From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 14/16] backlight: atmel-pwm-bl: remove obsolete driver
Date: Mon, 24 Mar 2014 16:54:12 +0100
Message-ID: <20140324155412.GA9083@piout.net>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-15-git-send-email-alexandre.belloni@free-electrons.com>
 <20140319142231.GF20872@samfundet.no>
 <000101cf449f$aa609960$ff21cc20$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000101cf449f$aa609960$ff21cc20$%han@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Hans-Christian Egtvedt' <egtvedt@samfundet.no>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'Nicolas Ferre' <nicolas.ferre@atmel.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Haavard Skinnemoen' <hskinnemoen@gmail.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Thierry Reding' <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On 21/03/2014 at 09:51:16 +0900, Jingoo Han wrote :
> On Wednesday, March 19, 2014 11:23 PM, Hans-Christian Egtvedt wrote:
> > Around Wed 19 Mar 2014 14:03:27 +0100 or thereabout, Alexandre Belloni wrote:
> > > The atmel-pwm-bl driver is now obsolete. It is not used by any mainlined boards
> > > and is replaced by the generic pwm_bl with the pawm-atmel driver using the
> > > generic PWM framework.
> > >
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> > Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 

You didn't comment on patch 08/16, are you fine with it ? I guess this
is the only one holding back the full series.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
