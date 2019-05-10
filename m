From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [RESEND PATCH v5 0/3] Add PM support to STM32 LP Timer drivers
Date: Fri, 10 May 2019 09:51:01 +0200
Message-ID: <45e934af-d677-d7d4-09ea-3ed01872dab6@st.com>
References: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, Loic PALLARDY <loic.pallardy@st.com>, tduszyns@gmail.com, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 4/18/19 11:37 AM, Fabrice Gasnier wrote:
> This patch series adds power management support for STM32 LP Timer:
> - PWM driver
> - Document the pinctrl states for sleep mode
> 
> It also adds device link between the PWM consumer and the PWM provider.
> This allows proper sequencing for suspend/resume (e.g. user will likely
> do a pwm_disable() before the PWM provider suspend executes), see [1].
> 
> [1] https://lkml.org/lkml/2019/2/5/770
> 

Hi Thierry,

Please let me know if you have some more comments on this series. It's
been under review since quite some time now.

Thanks in advance,
Best Regards,
Fabrice

> ---
> resend v5:
> - update collected acks
> 
> Changes in v5:
> - improve a warning message, fix a style issue.
> 
> Changes in v4:
> - improve error handling when adding the PWM consumer device link.
> 
> Changes in v3:
> - Move the device_link_add() call to of_pwm_get() as discussed with Uwe.
> 
> Changes in v2:
> - Don't disable PWM channel in PWM provider: rather refuse to suspend
>   and report an error as suggested by Uwe and Thierry.
> - Add patch 3/3 to propose device link addition.
> - No updates for STM32 LP Timer IIO driver. Patches can be send separately.
> 
> Fabrice Gasnier (3):
>   dt-bindings: pwm-stm32-lp: document pinctrl sleep state
>   pwm: stm32-lp: Add power management support
>   pwm: core: add consumer device link
> 
>  .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
>  drivers/pwm/core.c                                 | 50 ++++++++++++++++++++--
>  drivers/pwm/pwm-stm32-lp.c                         | 25 +++++++++++
>  include/linux/pwm.h                                |  6 ++-
>  4 files changed, 82 insertions(+), 8 deletions(-)
> 
