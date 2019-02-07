From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Thu, 7 Feb 2019 13:54:37 +0530
Message-ID: <CAJ2_jOFsyRR8tLpS6C_h1mkWh6WJjN6qFgDoSqKJGjhBieM3NQ@mail.gmail.com>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
 <20190206124442.GG21676@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190206124442.GG21676@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 6, 2019 at 6:14 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
> [...]
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> [...]
> > +static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
> > +                                 unsigned long rate)
> > +{
> > +     /* (1 << (16+scale)) * 10^9/rate = real_period */
> > +     unsigned long scale_pow =
> > +                     (pwm->approx_period * (u64)rate) / NSEC_PER_SEC;
>
> I think you need another div64_ul() for this one to fix the linker error
> that the 0-day builder was pointing out.

Yes, will fix this. Thanks for pointing it out.

>
> Thierry
