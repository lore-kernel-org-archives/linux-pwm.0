From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 17/17] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
Date: Thu, 18 Aug 2016 14:20:02 -0500
Message-ID: <20160818192002.GA26225@rob-hp-laptop>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-18-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-18-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, patrice.chotard@st.com, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Aug 16, 2016 at 10:35:08AM +0100, Lee Jones wrote:
> We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> be more inline with the naming conventions of the subsystem.  Where
> we used to treat each line as a channel, the PWM convention is to
> describe them as devices.

This is out of date now. Otherwise, the binding looks fine.

> The second documentation adaption entails adding support for PWM
> capture devices.  A new clock is required as well as an IRQ line.
> We're also adding a new property similar to the one described
> above, but for capture channels.  Typically, there will be less
> capture channels than PWM-out, since all channels have the latter
> capability, but only some have capture support.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-st.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
