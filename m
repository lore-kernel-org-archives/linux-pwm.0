From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] acpi: lpss: call pwm_add_table() for
	bsw PWM device
Date: Mon, 30 Jan 2017 09:28:09 +0100
Message-ID: <CAJZ5v0hS08PX88+bXcnCz_V5f_VZ1L49iXnu9rHwDGO2uM7Q0A@mail.gmail.com>
References: <20170122161409.21601-1-hdegoede@redhat.com>
 <20170122161409.21601-4-hdegoede@redhat.com>
 <20170130081839.GN3585@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170130081839.GN3585@ulmo.ba.sec>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pwm@vger.kernel.org

T24gTW9uLCBKYW4gMzAsIDIwMTcgYXQgOToxOCBBTSwgVGhpZXJyeSBSZWRpbmcKPHRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gU3VuLCBKYW4gMjIsIDIwMTcgYXQgMDU6MTQ6
MDlQTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3cm90ZToKPj4gT24geDg2IHdlIGRvIG5vdCBoYXZl
IGRldmljZXRyZWUgdG8gbGluayB0aGUgUFdNIGNvbnRyb2xsZXIgYW5kCj4+IHRoZSBkaXNwbGF5
IGNvbnRyb2xsZXIgdG9nZXRoZXIuIFNvIHNvbWVvbmUgbmVlZHMgdG8gY2FsbAo+PiBwd21fYWRk
X3RhYmxlKCkgdG8gY3JlYXRlIHRoZSBsaW5rLCBzbyB0aGF0IHRoZSBpOTE1IGRyaXZlcidzCj4+
IHB3bV9nZXQoZGV2LCAicHdtX2JhY2tsaWdodCIpIGNhbGwgcmV0dXJucyB0aGUgbHBzcycgcHdt
MC4KPj4KPj4gVGhlIFBXTSBzdWJzeXN0ZW0gZG9lcyBub3Qgd2FudCB0byBoYXZlIHB3bV9hZGRf
dGFibGUoKSBjYWxscwo+PiBkaXJlY3RseSBpbiBQV00gZHJpdmVycyAodGhpcyBsZWFkcyB0byBw
cm9iZSBvcmRlcmluZyBpc3N1ZXMpLAo+PiBzbyBsZXRzIGRvIGl0IGhlcmUgc2luY2UgdGhlIGFj
cGktbHBzcyBjb2RlIGlzIGFsd2F5cyBidWlsdGluLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5z
IGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgo+PiBBY2tlZC1ieTogVGhpZXJyeSBSZWRp
bmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4KPj4gLS0tCj4+IENoYW5nZXMgaW4gdjI6Cj4+
IC1TZXQgbmV3IHB3bV9sb29rdXAgbW9kdWxlX25hbWUgZmllbGQgaW4gdGhlIHRhYmxlCj4+IC0t
LQo+PiAgZHJpdmVycy9hY3BpL2FjcGlfbHBzcy5jIHwgMTMgKysrKysrKysrKysrKwo+PiAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKPgo+IFJhZmFlbCwgZG8geW91IG1pbmQgaWYg
SSB0YWtlIHRoaXMgdGhyb3VnaCB0aGUgUFdNIHRyZWUgdG8gcmVzb2x2ZSB0aGUKPiBidWlsZC10
aW1lIGRlcGVuZGVuY3k/CgpObywgSSBkb24ndCwgcGxlYXNlIGdvIGFoZWFkLCB1bmxlc3MgTWlr
YS9BbmR5IHNlZSBhbnkgcHJvYmxlbXMgaW4gaXQuCgpUaGFua3MsClJhZmFlbApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBs
aXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
