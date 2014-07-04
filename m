From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 2/7] pwm: add support for atmel-hlcdc-pwm device
Date: Fri, 4 Jul 2014 15:31:16 +0200
Message-ID: <20140704153116.5fab1e1b@bbrezillon>
References: <1402329860-27520-1-git-send-email-boris.brezillon@free-electrons.com>
	<1402329860-27520-3-git-send-email-boris.brezillon@free-electrons.com>
	<539D6328.4020505@traphandler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <539D6328.4020505@traphandler.com>
Sender: linux-doc-owner@vger.kernel.org
To: jjhiblot@traphandler.com
Cc: Thierry Reding <thierry.reding@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
List-Id: linux-pwm@vger.kernel.org

On Sun, 15 Jun 2014 11:11:04 +0200
Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:


> >  
> > +config PWM_ATMEL_HLCDC_PWM
> > +	tristate "Atmel HLCDC PWM support"
> > +	depends on MFD_ATMEL_HLCDC
> I'd personnaly prefer a 'select' instead of 'depends on' here. Or maybe
> the MFD driver should enabled y defaut for platforms supporting the hlcdc.

After taking a closer look at other drivers, it seems most of sub
drivers "depends on" the MFD driver, so, unless other people complain
about that, I'll keep this definition.

Lee, any opinion on this point ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
