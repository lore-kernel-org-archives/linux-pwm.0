From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v3] pwm: mediatek: fix up PWM4 and PWM5 malfunction on
 MT7623
Date: Sat, 3 Mar 2018 06:34:50 +0800
Message-ID: <1520030090.8089.186.camel@mtkswgap22>
References: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
 <20180302105719.GC27178@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180302105719.GC27178@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mediatek@lists.infradead.org, Zhi Mao <zhi.mao@mediatek.com>, John Crispin <john@phrozen.org>, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, 2018-03-02 at 11:57 +0100, Thierry Reding wrote:
> On Thu, Mar 01, 2018 at 04:19:12PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> > control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> > programming on PWM hardware causes waveform cannot be output as expected.
> > Thus, the patch adds the extra condition for fixing up the weird case to
> > let PWM4 or PWM5 able to work on MT7623.
> > 
> > v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
> > v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Zhi Mao <zhi.mao@mediatek.com>
> > Cc: John Crispin <john@phrozen.org>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> >  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> [...]
> > @@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
> > +		/*
> > +		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
> > +		 * from the other PWMs on MT7623.
> > +		 */
> > +		reg_width = PWM45DWIDTH_FIXUP;
> > +		reg_thres = PWM45THRES_FIXUP;
> > +	}
> 
> I don't understand this. According to the condition above the above
> would also use the PWM[4,5] "fixup" register offsets with PWM[3]. Should
> the condition be pwm->hwpwm > 3?
> 
> Thierry


PWM[4,5] are the naming specified in datasheet and kept it as is here
and driver or userspace would use index 3 and 4 to have a reference to
them respectively.
