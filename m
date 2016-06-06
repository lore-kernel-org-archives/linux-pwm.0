From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 00/11] pwm: Add support for PWM Capture
Date: Mon, 6 Jun 2016 20:46:03 +0200
Message-ID: <20160606204603.09a8d2cf@bbrezillon>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
	<20160429094010.6bfb131c@bbrezillon>
	<20160606153231.GE1525@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36617 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208AbcFFSqH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jun 2016 14:46:07 -0400
In-Reply-To: <20160606153231.GE1525@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, ajitpal.singh@st.com, thierry.reding@gmail.com, maxime.coquelin@st.com

On Mon, 6 Jun 2016 16:32:31 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Fri, 29 Apr 2016, Boris Brezillon wrote:
> 
> > Hi Lee,
> > 
> > On Fri, 22 Apr 2016 11:18:04 +0100
> > Lee Jones <lee.jones@linaro.org> wrote:
> >   
> > > The first part of this set extends the current PWM API to allow external
> > > code to request a PWM Capture.  Subsequent patches then make use of the
> > > new API by providing a userspace offering via /sysfs.  The final part of
> > > the set supplies PWM Capture functionality into the already existing STi
> > > PWM driver.  
> > 
> > Is there a reason you decided to not put this driver in IIO? IMHO, it
> > would be more appropriate to make your PWM device an MFD that can either
> > bind to the PWM or the capture driver.
> > And BTW, IIO already has a sysfs interface (you may have to extend the
> > API to support your type of capture though).  
> 
> Multi-Function Device drivers can only be justified if the IP
> contained does not and can not live in a single subsystem.  The IP
> which controls both PWM-in and PWM-out in this device is the same.  I
> can't fathom a sane reason why you would wish to separate this
> functionality over multiple subsystems.
> 

Well, I still think what you describe as PWM-in is actually a capture
device that would perfectly fit in the IIO subsystem, and I guess you
can't use the PWM IP as a capture and waveform generator device as the
same time, which is why I suggested the MFD approach to select the mode.

Anyway, I'm not the PWM or the IIO maintainer, so I'm just sharing my
opinion here.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
