From: Jeff LaBundy <jeff@labundy.com>
Subject: Re: [PATCH v5 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Date: Sun, 22 Mar 2020 21:16:05 -0500
Message-ID: <20200323021605.GA2731@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
 <20200228034220.GA3510@labundy.com>
 <20200302120458.GY3494@dell>
 <20200302141117.GA11787@labundy.com>
 <20200302142405.GA3494@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200302142405.GA3494@dell>
Sender: linux-input-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: dmitry.torokhov@gmail.com, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
List-Id: linux-pwm@vger.kernel.org

Hi Lee,

On Mon, Mar 02, 2020 at 02:24:05PM +0000, Lee Jones wrote:
> On Mon, 02 Mar 2020, Jeff LaBundy wrote:
> 
> > Hi Lee,
> > 
> > On Mon, Mar 02, 2020 at 12:04:58PM +0000, Lee Jones wrote:
> > > On Thu, 27 Feb 2020, Jeff LaBundy wrote:
> > > 
> > > > Hi Lee,
> > > > 
> > > > On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > 
> > > > > Well done Jeff.  Good job.
> > > > > 
> > > > > Applied, thanks.
> > > > > 
> > > > 
> > > > Thank you for your kind words as well as your support in fleshing out this
> > > > series.
> > > > 
> > > > Just to confirm, does your offer to take the remainder (once everything is
> > > > approved) through immutable branches still stand?
> > > 
> > > Depends how quickly you can get the other drivers turned around.
> > 
> > With Uwe's approval from Friday, all five drivers are complete. Dmitry and
> > Jonathan's approvals were given in previous review cycles and were carried
> > forward with their permission. If anything else is required, please let me
> > know.
> 
> Does Uwe's review mean that Thierry's is not required?

Sorry about that; I was jumping the gun (thank you Uwe for clarifying).
The pwm patch still needs an Ack from Thierry before it can be applied.

I have not received any feedback from Thierry throughout this patch set,
and I'd like to unblock the remainder if possible. In case Thierry does
not respond by the time you elect to send your next pull request, would
you be willing to drop the pwm patch and take the input and iio patches
through your tree?

If so, I'll re-send the pwm patch on its own to Thierry during a future
cycle so that he can take it through his tree at his convenience.

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

Kind regards,
Jeff LaBundy
