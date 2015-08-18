From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH] pwm: add TLC59108/TLC59116 PWM driver
Date: Tue, 18 Aug 2015 17:14:40 +0200
Message-ID: <20150818151440.GH4381@lunn.ch>
References: <1439905927-27861-1-git-send-email-tomi.valkeinen@ti.com>
 <1439905927-27861-2-git-send-email-tomi.valkeinen@ti.com>
 <20150818141959.GF4381@lunn.ch>
 <55D34807.2020609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:33046 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbbHRPV6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 18 Aug 2015 11:21:58 -0400
Content-Disposition: inline
In-Reply-To: <55D34807.2020609@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>

> > The hardware does allow you to change the period, but there is only
> > one clock generator for all the channels. If you are going to make the
> 
> Hmm... How does that work?

I does not :-(

It is something like 8 months since i rewrote the LED class driver,
and i've forgotten how the thing actually works.

Sorry
	Andrew
