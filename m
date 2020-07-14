From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [stable v5.4.x] pwm: jz4740: Fix build failure
Date: Tue, 14 Jul 2020 18:58:23 +0200
Message-ID: <20200714165823.GA2127080@kroah.com>
References: <20200710102758.8341-1-u.kleine-koenig@pengutronix.de>
 <DB8C7C01-0FBB-4A9F-B068-15C06BBC0873@goldelico.com>
 <20200710194702.ire4deel2zn7mnxk@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200710194702.ire4deel2zn7mnxk@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, linux-mips@vger.kernel.org, tsbogend@alpha.franken.de
List-Id: linux-pwm@vger.kernel.org

On Fri, Jul 10, 2020 at 09:47:02PM +0200, Uwe Kleine-König wrote:
> On Fri, Jul 10, 2020 at 12:48:36PM +0200, H. Nikolaus Schaller wrote:
> > 
> > > Am 10.07.2020 um 12:27 schrieb Uwe Kleine-König <u.kleine-koenig@pengutronix.de>:
> > > 
> > > When commit 9017dc4fbd59 ("pwm: jz4740: Enhance precision in calculation
> > > of duty cycle") from v5.8-rc1 was backported to v5.4.x its dependency on
> > > commit ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver") was not
> > > noticed which made the pwm-jz4740 driver fail to build.
> > 
> > Please can you add my "reported by?"
> 
> Greg, can you please add this while applying? (Assuming you're ok with
> this change and ideally Paul can confirm the change is fine.)
> 
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>

Now added, thanks.
