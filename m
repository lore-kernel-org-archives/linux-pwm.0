From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 00/11] pwm: Add support for PWM Capture
Date: Fri, 29 Apr 2016 09:40:10 +0200
Message-ID: <20160429094010.6bfb131c@bbrezillon>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, ajitpal.singh@st.com, thierry.reding@gmail.com, maxime.coquelin@st.com
List-Id: linux-pwm@vger.kernel.org

Hi Lee,

On Fri, 22 Apr 2016 11:18:04 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> The first part of this set extends the current PWM API to allow external
> code to request a PWM Capture.  Subsequent patches then make use of the
> new API by providing a userspace offering via /sysfs.  The final part of
> the set supplies PWM Capture functionality into the already existing STi
> PWM driver.

Is there a reason you decided to not put this driver in IIO? IMHO, it
would be more appropriate to make your PWM device an MFD that can either
bind to the PWM or the capture driver.
And BTW, IIO already has a sysfs interface (you may have to extend the
API to support your type of capture though).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
