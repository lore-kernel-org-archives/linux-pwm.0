From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Date: Mon, 2 Mar 2020 15:23:34 +0100
Message-ID: <20200302142334.orvi7aqbsbnfspy5@pengutronix.de>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
 <20200228034220.GA3510@labundy.com>
 <20200302120458.GY3494@dell>
 <20200302141117.GA11787@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200302141117.GA11787@labundy.com>
Sender: linux-input-owner@vger.kernel.org
To: Jeff LaBundy <jeff@labundy.com>
Cc: Lee Jones <lee.jones@linaro.org>, dmitry.torokhov@gmail.com, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Mar 02, 2020 at 08:11:17AM -0600, Jeff LaBundy wrote:
> On Mon, Mar 02, 2020 at 12:04:58PM +0000, Lee Jones wrote:
> > On Thu, 27 Feb 2020, Jeff LaBundy wrote:
> > 
> > > Hi Lee,
> > > 
> > > On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:
> > > 
> > > [...]
> > > 
> > > > 
> > > > Well done Jeff.  Good job.
> > > > 
> > > > Applied, thanks.
> > > > 
> > > 
> > > Thank you for your kind words as well as your support in fleshing out this
> > > series.
> > > 
> > > Just to confirm, does your offer to take the remainder (once everything is
> > > approved) through immutable branches still stand?
> > 
> > Depends how quickly you can get the other drivers turned around.
> 
> With Uwe's approval from Friday, all five drivers are complete.

Note that I'm "only" reviewer of the PWM stuff and Thierry is the one
responsible for the pwm-tree. So you need his ack to take the pwm patch
through a different tree.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
