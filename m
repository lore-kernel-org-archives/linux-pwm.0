From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
Date: Tue, 6 Sep 2016 10:36:49 +0200
Message-ID: <bd7ea1db-d8f9-f075-14ef-732d9bb65e77@baylibre.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
 <20160905090052.GG3532@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160905090052.GG3532@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: carlo@caione.org, khilman@baylibre.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On 09/05/2016 11:00 AM, Thierry Reding wrote:
> On Mon, Aug 22, 2016 at 05:36:30PM +0200, Neil Armstrong wrote:
>> Add support for the PWM controller found in the Amlogic SoCs.
>> This driver supports the Meson8b and GXBB SoCs.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/pwm/Kconfig     |   9 +
>>  drivers/pwm/Makefile    |   1 +
>>  drivers/pwm/pwm-meson.c | 528 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 538 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-meson.c
> 
> Hi Neil,
> 
> sorry for taking so long to review this. I had actually started to write
> a review email since I had noticed a couple of slight oddities about the
> driver structure (primarily this was about how channel-specific data was
> split between struct meson_pwm_channel and struct meson_pwm_chip), but I
> ended up making some changes to the driver in order to see what my
> suggestions would look like, and if they would indeed improve things.
> But once I had done that, I thought it a bit pointless to make that into
> review comments and decided to just push what I had done and ask you to
> take a look, and if you had no objections to the changes take the driver
> for a spin to see if it still worked as expected.

We re-run our tests and I found 2 bugs, the first one is in meson_pwm_enable(),
only the channel A was setup, the fix is :

static void meson_pwm_enable(...)
-	u32 value, clk_shift, clk_enable, enable;
+	u32 reg, value, clk_shift, clk_enable, enable;

 	switch (id) {
 	case 0:
[...]
+		reg = REG_PWM_A;
 		break;
 	case 1:
[...]
+		reg = REG_PWM_B;
 		break;
 	}
[...]
-	writel(value, meson->base + REG_PWM_A);
+	writel(value, meson->base + reg);

The second bug is in probe(), I understand the point to allocate dynamically the channels
and attach them to each pwm chip, but when calling meson_pwm_init_channels() we get an OOPS
because meson->chip.pwms[i] are allocated in pwmchip_add().
Moving meson_pwm_init_channels() would fix this, but in case of a clk PROBE_DEFER, we would need
to remove back the pwmchip, which is a quite a bad design decision....

The smartest fix I found was to allocate channels in probe, init them them attach them after pwmchip_add():

static int meson_pwm_init_channels(..., struct meson_pwm_channel *channels)
{
+	struct meson_pwm_channel *channels;
[...]
-	for (i = 0; i < meson->chip.npwm; i++) {
-		struct pwm_device *pwm = &meson->chip.pwms[i];
-		struct meson_pwm_channel *channel;
-
-		channel = devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
-		if (!channel)
-			return -ENOMEM;
+	if (!channels)
+		return -EINVAL;

+	for (i = 0; i < meson->chip.npwm; i++) {
[...]
+		memset(&channels[i], 0, sizeof(struct meson_pwm_channel));
[...]
//Rename "channel->" into "channels[i]."//
[...]
-		pwm_set_chip_data(pwm, channel);
 	}

 	return 0;
}

+static void meson_pwm_add_channels_data(struct meson_pwm *meson,
+					struct meson_pwm_channel *channels)
+{
+	unsigned int i;
+
+	for (i = 0; i < meson->chip.npwm; i++)
+		pwm_set_chip_data(&meson->chip.pwms[i], &channels[i]);
+}

static int meson_pwm_probe(struct platform_device *pdev)
{
+	struct meson_pwm_channel *channels;
[...]
-	err = meson_pwm_init_channels(meson);
-	if (err < 0)
-		return err;
-
 	meson->chip.dev = &pdev->dev;
[...]
 	meson->chip.of_pwm_n_cells = 3;

+	channels = devm_kmalloc_array(&pdev->dev, 2, sizeof(*meson),
+				      GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	err = meson_pwm_init_channels(meson, channels);
+	if (err < 0)
+		return err;
+
 	err = pwmchip_add(&meson->chip);
[...]
+	meson_pwm_add_channels_data(meson, channels);
+
 	platform_set_drvdata(pdev, meson);

 	return 0;
}

The fix driver is in a separate branch, rebased on your for-next :
https://github.com/superna9999/linux/tree/amlogic/v4.8/pwm-for-next

and in a signed tag I can transform in a pull request if needed :
https://github.com/superna9999/linux/releases/tag/amlogic/v4.8/pwm-for-next-for-v4

[...]
> 
> I've pushed my modifications to the driver to the linux-pwm repository:
> 
> 	https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/log/?h=for-next
> 
> Alternatively you can also take a look at the for-4.9/drivers branch,
> but they're currently the same thing.
> 
> Thierry
> 

Thanks,
Neil
